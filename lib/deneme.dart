import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Deneme extends StatefulWidget {
  @override
  _DenemeState createState() => _DenemeState();
}

List listItemtur = ["Tümü", "Doğa", "Tarihi", "Eğlence"];

class _DenemeState extends State<Deneme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            color: Colors.brown,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: listItemtur.length,
              itemBuilder: (BuildContext context, int index) {
                return new Text(listItemtur[index]);
              })
        ],
      ),
    );
  }

  getMekanlar() async {
    //final mekanModel = Provider.of<MekanModel>(context, listen: false);

    //Yorum yorum =
    //  Yorum(ad: "Burak", mekanID: "mekanid147", userID: "userID147");

    //mekanModel.addYorum(yorum);

    //List<Yorum> list = await mekanModel.getYorumlar("mekanid147");
    //mekanModel.deleteYorum(list[0].id,"mekanid147");
  }

  calistir() {
    String aciklama = "";
    String ad = "";
    String adres = "";
    int begeniSayisi = 0;
    String foto1 = "";
    String foto2 = "";
    String foto3 = "";
    String konum = "";
    String sehir = "Antalya";
    String tur = "";

    //final mekanModel = Provider.of<MekanModel>(context,listen: false);
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection('mekanlar').add({
      'aciklama': aciklama,
      'ad': ad,
      'adres': adres,
      'begeniSayisi': begeniSayisi,
      'foto1': foto1,
      'foto2': foto2,
      'foto3': foto3,
      'konum': konum,
      'sehir': sehir,
      'tur': tur,
    });
  }
}
