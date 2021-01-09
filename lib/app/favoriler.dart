import 'package:flutter/material.dart';
import 'package:flutter_city_app/app/detay_page.dart';
import 'package:flutter_city_app/main.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/viewmodel/mekan_model.dart';
import 'package:provider/provider.dart';

class Favoriler extends StatefulWidget {
  @override
  _FavorilerState createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.temaColorBlack,
      body: Column(
        children: <Widget>[
          _baslik(),
          _Listele(),
        ],
      ),
    );
  }

  _baslik() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: MyApp.temaColorHomeGreen,
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              width: 100,
            ),
            Text(
              "Favorilerim",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontStyle: FontStyle.italic),
            ),

          ],
        ),
      ),
    );
  }

  _cardIcerik(Mekan mekan) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height * 0.2;
    return Container(
      margin: EdgeInsets.all(5),
      width: genislik,
      height: yukseklik,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: MyApp.temaColorHomeGreen),
          color: MyApp.temaColorBlack,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: yukseklik - 10,
                width: yukseklik - 10,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(mekan.foto1), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      color: MyApp.temaColorBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.thumb_up_alt,
                        color: MyApp.temaColorHomeGreen,
                      ),
                      Text(
                        "${mekan.begeniSayisi}",
                        style: TextStyle(
                            color: MyApp.temaColorHomeGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: MyApp.temaColorHomeGreen, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: genislik * 0.55,
                      height: 30,
                      child: Center(
                          child: Text(
                        "${mekan.ad}",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ))),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 200,
                      height: 80,
                      child: SingleChildScrollView(
                        child: Text(
                          "${mekan.aciklama}",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: MyApp.temaColorHomeGreen, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: genislik * 0.55,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${mekan.sehir}/${mekan.tur}",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetayPage(mekan)));
                            },
                            child: Text(
                              "Devamı...",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _Listele() {
    final mekanModel = Provider.of<MekanModel>(context);

    if (mekanModel.favmekanlar.length > 0) {
      return Expanded(
        child: Container(
          //color: Colors.indigo,
          //padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10),

          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: mekanModel.favmekanlar.length,
              itemBuilder: (context, index) {
                return _cardIcerik(mekanModel.favmekanlar[index]);
              }),
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
