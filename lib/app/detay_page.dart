import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_city_app/main.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/model/yorum.dart';
import 'package:flutter_city_app/viewmodel/mekan_model.dart';
import 'package:flutter_city_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class DetayPage extends StatefulWidget {
  Mekan _mekan;

  DetayPage(Mekan mekan) {
    this._mekan = mekan;
  }

  @override
  _DetayPageState createState() => _DetayPageState(_mekan);
}

class _DetayPageState extends State<DetayPage> {
  TextEditingController _controllerYorum;
  Mekan mekan;
  bool durumbegeni = false;
  bool durumfav = false;

  _DetayPageState(Mekan mekan) {
    this.mekan = mekan;
  }

  @override
  void initState() {
    super.initState();
    _favKontrol();
    _BegeniKontrol();
    _yorumlariGetir();
    _controllerYorum = TextEditingController();
  }

  @override
  void dispose() {
    _controllerYorum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.temaColorBlack,
      body: ListView(
        children: <Widget>[
          Container(
            color: MyApp.temaColorHomeGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    final mekanModel =
                        Provider.of<MekanModel>(context, listen: false);
                    mekanModel.getMekanlar();
                    Navigator.pop(context);
                  },
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyApp.temaColorHomeGreen,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                      "${mekan.ad}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          ),
                    ))),
                IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 29,
                      color: durumfav == true
                          ? MyApp.temaColorGreen
                          : Colors.black,
                    ),
                    onPressed: () {
                      _favoriler();
                    })
              ],
            ),
          ),
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 210.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(mekan.foto1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(mekan.foto2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(mekan.foto3),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyApp.temaColorHomeGreen, width: 5),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              color: MyApp.temaColorBlack,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: MyApp.temaColorBlack,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: MyApp.temaColorHomeGreen, width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Sehir : ${mekan.sehir}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Tür : ${mekan.tur}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                _Begeniler();
                              },
                              child: Icon(
                                Icons.thumb_up_off_alt,
                                size: 35,
                                color: durumbegeni == true
                                    ? MyApp.temaColorGreen
                                    : Colors.white,
                              )),
                          Text(
                            "${mekan.begeniSayisi} beğenme",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: MyApp.temaColorHomeGreen,
                  thickness: 3,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: MyApp.temaColorHomeGreen,
                    border:
                        Border.all(color: MyApp.temaColorHomeGreen, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                      child: Text(
                    "${mekan.aciklama}",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: MyApp.temaColorBlack,
              border: Border.all(color: MyApp.temaColorHomeGreen, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Adres Bilgileri",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
                Divider(
                  color: MyApp.temaColorHomeGreen,
                  thickness: 3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyApp.temaColorHomeGreen),
                  child: SingleChildScrollView(
                      child: Text(
                    "${mekan.adres}",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _yorumContainer(),
        ],
      ),
    );
  }

  bool _favoriler() {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);
    setState(() {
      if (durumfav == true) {
        mekanModel.deleteFav(mekanModel.UserID, mekan.id);
        durumfav = false;
        return false;
      } else {
        mekanModel.addFav(mekanModel.UserID, mekan.id);
        durumfav = true;
        return true;
      }
    });
  }

  bool _Begeniler() {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);
    setState(() {
      if (durumbegeni == true) {
        mekanModel.deleteBegen(mekanModel.UserID, mekan.id);
        mekan.begeniSayisi--;
        durumbegeni = false;
        return false;
      } else {
        mekanModel.addBegen(mekanModel.UserID, mekan.id);
        mekan.begeniSayisi++;
        durumbegeni = true;
        return true;
      }
    });
  }

  _favKontrol() async {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);

    bool deger = await mekanModel.favKontrol(mekanModel.UserID, mekan.id);
    setState(() {
      durumfav = deger;
    });
  }

  _BegeniKontrol() async {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);

    bool deger = await mekanModel.BegeniKontrol(mekanModel.UserID, mekan.id);
    setState(() {
      durumbegeni = deger;
    });
  }

  _alertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Burak"),
            content: Text("Hello World"),
            actions: <Widget>[
              RaisedButton(
                child: Text("Bas"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _yorumContainer() {
    final mekanModel = Provider.of<MekanModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: MyApp.temaColorBlack,
        border: Border.all(color: MyApp.temaColorHomeGreen, width: 5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Mekan Değerlendirmeleri",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Divider(
            color: MyApp.temaColorHomeGreen,
            thickness: 3,
          ),
          mekanModel.yorumlar.length > 0
              ? Container(
                  height: mekanModel.yorumlar.length > 3 ? 300 : null,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: mekanModel.yorumlar.length,
                      itemBuilder: (context, index) {
                        return _YorumcardIcerik(
                            mekanModel.yorumlar[index], mekanModel.UserID);
                      }),
                )
              : Container(height: 50,
                  child: Center(
                    child: Text("İlk Yorumu Sen Yap...",style: TextStyle(color: Colors.white),),
                  ),
                ),
          Divider(
            color: MyApp.temaColorHomeGreen,
            thickness: 3,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: MyApp.temaColorHomeGreen, width: 3),
                borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width,
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _controllerYorum,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Değerlendir...',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: () {
              yorumKontrol();
            },
            color: MyApp.temaColorHomeGreen,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                    child: Text(
                  "Gönder",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
          ),
        ],
      ),
    );
  }

  _yorumlariGetir() async {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);
    mekanModel.MekanID = mekan.id;
    await mekanModel.getYorumlar();
  }

  _YorumcardIcerik(Yorum yorum, String userID) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.only(left: 10, top: 5),
      decoration: BoxDecoration(
        color: MyApp.temaColorHomeGreen,
        border: Border.all(color: MyApp.temaColorHomeGreen),
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              yorum.ad,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 5),
            width: MediaQuery.of(context).size.width,
            child: Text(
              yorum.yorum,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              top: 5,
              right: 10,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${yorum.date.toDate().day.toString()}.${yorum.date.toDate().month.toString()}.${yorum.date.toDate().year.toString()} ${yorum.date.toDate().hour.toString()}:${yorum.date.toDate().minute.toString()}",
                  style: TextStyle(color: Colors.white),
                ),
                yorum.userID == userID
                    ? Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteYorum(mekan.id, yorum.id);
                              }),
                        ],
                      )
                    : Row(
                        children: <Widget>[],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  yorumKontrol() async {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);
    final userModel = Provider.of<UserModel>(context, listen: false);
    mekanModel.yorum = Yorum(
      userID: mekanModel.UserID,
      mekanID: mekan.id,
      ad: userModel.kullanici.userName,
      yorum: _controllerYorum.text,
    );
    await mekanModel.addYorum();
    mekanModel.MekanID = mekan.id;
    await mekanModel.getYorumlar();
    setState(() {
      _controllerYorum.text = "";
    });
  }

  _deleteYorum(String mekanId, String yorumId) async {
    final mekanModel = Provider.of<MekanModel>(context, listen: false);
    mekanModel.MekanID = mekanId;
    mekanModel.YorumID = yorumId;
    await mekanModel.deleteYorum();
    setState(() {});
  }
}
