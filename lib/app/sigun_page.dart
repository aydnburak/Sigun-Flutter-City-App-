import 'package:flutter/material.dart';
import 'package:flutter_city_app/app/detay_page.dart';
import 'package:flutter_city_app/main.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/viewmodel/mekan_model.dart';
import 'package:provider/provider.dart';

class SigunPage extends StatefulWidget {
  @override
  _SigunPageState createState() => _SigunPageState();
}

class _SigunPageState extends State<SigunPage> {
  List listItem = ["Antalya", "İstanbul", "İzmir"];
  List listItemtur = ["Tümü", "Doğa", "Tarihi", "Eğlence"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.temaColorBlack,
      body: Column(
        children: [
          _baslikEkran(),
          _Listele(),
        ],
      ),
    );
  }

  _baslikEkran() {
    final mekanModel = Provider.of<MekanModel>(context);
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            border: Border.all(color: MyApp.temaColorHomeGreen, width: 4),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)),
            image: DecorationImage(
                image: mekanModel.sehir == null
                    ? AssetImage("assets/İstanbul.jpg")
                    : AssetImage("assets/${mekanModel.sehir}.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 15,
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: MyApp.temaColorBlack,
                  border: Border.all(color: MyApp.temaColorHomeGreen, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                    dropdownColor: MyApp.temaColorBlack,
                    hint: Text("Sehir Seç",
                        style: TextStyle(color: Colors.white)),
                    value: mekanModel.sehir,
                    underline: SizedBox(),
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    items: listItem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(
                          valueItem,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        mekanModel.sehir = newValue;
                      });
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.32,
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: MyApp.temaColorBlack,
                  border: Border.all(color: MyApp.temaColorHomeGreen, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                    dropdownColor: MyApp.temaColorBlack,
                    hint:
                        Text("Tür Seç", style: TextStyle(color: Colors.white)),
                    value: mekanModel.tur,
                    underline: SizedBox(),
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    items: listItemtur.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(
                          valueItem,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        mekanModel.tur = newValue;
                      });
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: 45,
                child: RaisedButton(
                    color: MyApp.temaColorHomeGreen,
                    child: Text(
                      "ARA",
                      style: TextStyle(fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side:
                            BorderSide(color: MyApp.temaColorBlack, width: 2)),
                    onPressed: () {
                      setState(() {
                        mekanModel.getMekanlar();
                      });
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }

  _cardIcerik(Mekan mekan) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: MyApp.temaColorHomeGreen),
          color: MyApp.temaColorBlack,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
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
              )),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: MyApp.temaColorHomeGreen, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "${mekan.ad}",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Text(
                          "${mekan.aciklama}",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: MyApp.temaColorHomeGreen, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                      ),
                    ),
                  ),
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
    if (mekanModel.mekanlar.length > 0) {
      return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: mekanModel.mekanlar.length,
            itemBuilder: (context, index) {
              return _cardIcerik(mekanModel.mekanlar[index]);
            }),
      );
    } else {
      return Expanded(
        child: Center(
          child: Text("Aradığınız Kriterlerde Mekan Bulunamadı...",style: TextStyle(color: Colors.white),),
        ),
      );
    }
  }

}
