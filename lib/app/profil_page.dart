import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_city_app/main.dart';
import 'package:flutter_city_app/viewmodel/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _controllerUserName;
  File _profilFoto;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

  void _kameradanFotoCek() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _profilFoto = File(pickedFile.path);

      Navigator.of(context).pop();
    });
  }

  void _galeridenResimSec() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto = File(pickedFile.path);

      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    _controllerUserName.text = _userModel.kullanici.userName;
    return Scaffold(
      backgroundColor: MyApp.temaColorBlack,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              _arkaPlan(),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _profileText(),
                    _profilAvatar(),
                    Container(height: 30,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: _userModel.kullanici.email,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyApp.temaColorBlack,
                          labelText: "E-posta",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 22),
                          hintText: "E-postanız...",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 22),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        controller: _controllerUserName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyApp.temaColorBlack,
                          labelText: "Kullanıcı adı",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 22),
                          hintText: "Kullanıcı adı",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 22),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: MyApp.temaColorHomeGreen,
                        onPressed: () {
                          _userNameGuncelle();
                          _profilFotoGuncelle();
                        },
                        child: Text("Degişiklikleri Kaydet"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Profil',
        style: TextStyle(
          fontSize: 35.0,
          letterSpacing: 1.5,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _userNameGuncelle() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.updateUserName(
        _userModel.kullanici.userID, _controllerUserName.text);

    if (sonuc) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Başarılı"),
              content: Text("UserName Degiştirildi"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Tamam"))
              ],
            );
          });
    } else {
      _controllerUserName.text = _userModel.kullanici.userName;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Hata"),
              content: Text("UserName Zaten Kullanimda"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Tamam"))
              ],
            );
          });
    }
  }

  void _profilFotoGuncelle() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_profilFoto != null) {
      await _userModel.updateFile(
          _userModel.kullanici.userID, "profil_foto", _profilFoto);
    }
  }

  Widget _arkaPlan() {
    return CustomPaint(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      painter: HeaderCurvedContainer(),
    );
  }

  Widget _profilAvatar() {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: MyApp.temaColorBlack, width: 5),
              shape: BoxShape.circle,
              color: MyApp.temaColorHomeGreen,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _profilFoto != null
                    ? FileImage(_profilFoto)
                    : _userModel.kullanici.profilUrl.isNotEmpty
                        ? NetworkImage(_userModel.kullanici.profilUrl)
                        : NetworkImage(
                            "https://www.kolaydata.com/wp-content/uploads/2018/10/windows-yeni-kullanici-ekleme-kapak.png"),
              ),
            ),
          ),
          Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyApp.temaColorBlack),
                child: IconButton(
                    icon: Icon(Icons.camera,color: MyApp.temaColorHomeGreen,),
                    iconSize: 50,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 160,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("Kameradan Çek"),
                                    onTap: () {
                                      _kameradanFotoCek();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text("Galeriden Seç"),
                                    onTap: () {
                                      _galeridenResimSec();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ))
        ],
      ),
    );
  }
}

//Color(0xff555555)
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = MyApp.temaColorHomeGreen;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
