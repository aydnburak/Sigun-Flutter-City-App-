import 'package:flutter/material.dart';
import 'package:flutter_city_app/app/favoriler.dart';
import 'package:flutter_city_app/app/sigun_page.dart';
import 'package:flutter_city_app/app/profil_page.dart';
import 'package:flutter_city_app/main.dart';
import 'package:flutter_city_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

enum Sayfalar { profil, sigun, favoriler }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double ekranYuksekligi, ekranGenisligi;
  bool menuAcikMi = false;
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _menuOfsetAnimation;
  final Duration _duration = Duration(milliseconds: 200);
  Sayfalar _sayfa = Sayfalar.sigun;

  Widget _sayfaYonlendirme() {
    if (_sayfa == Sayfalar.profil) {
      return ProfilPage();
    } else if (_sayfa == Sayfalar.favoriler) {
      return Favoriler();
    } else {
      return SigunPage();
    }
  }

  void _cikisYap() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await _userModel.singOut();
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.8).animate(_controller);
    _menuOfsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            menuOlustur(context),
            anaSayfaOlustur(context),
          ],
        ),
      ),
    );
  }

  Widget menuOlustur(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SlideTransition(
        position: _menuOfsetAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _avatar(),
                  _kullaniciBilgi(),
                  _menu(),
                  _cikis(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget anaSayfaOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikMi ? 0.4 * ekranGenisligi : 0,
      right: menuAcikMi ? -0.3 * ekranGenisligi : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius:
              menuAcikMi ? BorderRadius.all(Radius.circular(16)) : null,
          color: Colors.grey,
          elevation: 20,
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                _sayfaYonlendirme(),
                Positioned(
                  top: 5,
                  left: 5,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _menuControl();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MyApp.temaColorHomeGreen, width: 3),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/menu.png"))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _menuControl() {
    if (menuAcikMi) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    menuAcikMi = !menuAcikMi;
  }

  Widget _avatar() {
    final UserModel _userModel = Provider.of<UserModel>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: MyApp.temaColorBlack, width: 5),
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _userModel.kullanici.profilUrl.isNotEmpty
                ? NetworkImage(_userModel.kullanici.profilUrl)
                : NetworkImage(
                    "https://www.kolaydata.com/wp-content/uploads/2018/10/windows-yeni-kullanici-ekleme-kapak.png"),
          ),
        ),
      ),
    );
  }

  Widget _menu() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _menuControl();
                _sayfa = Sayfalar.sigun;
              });
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              color: MyApp.temaColorBlack,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/sigunButton.jpeg"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      "Sigun",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _menuControl();
                _sayfa = Sayfalar.profil;
              });
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              color: MyApp.temaColorBlack,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/profilpage.png"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      "Profil",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _menuControl();
                _sayfa = Sayfalar.favoriler;
              });
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              color: MyApp.temaColorBlack,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Center(
                          child: Icon(
                        Icons.favorite,
                        color: MyApp.temaColorGreen,
                        size: 30,
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      "Favoriler",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }

/*
Text(
                    "Favoriler",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )
 */
  Widget _cikis() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyApp.temaColorBlack,
      ),
      child: RaisedButton(
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: MyApp.temaColorHomeGreen, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: () => _cikisYap(),
        color: MyApp.temaColorBlack,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Çıkış",
              style: TextStyle(color: MyApp.temaColorHomeGreen, fontSize: 23),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.logout,
              color: MyApp.temaColorHomeGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _kullaniciBilgi() {
    final UserModel _userModel = Provider.of<UserModel>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Text(
              _userModel.kullanici.userName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                _userModel.kullanici.email,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
