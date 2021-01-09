import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_city_app/model/favoriler.dart';
import 'package:flutter_city_app/model/kullanici.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/model/yorum.dart';
import 'package:flutter_city_app/services/db_base.dart';

class FirestoreDBService implements DBBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(Kullanici kullanici) async {
    await _firestore
        .collection("users")
        .doc(kullanici.userID)
        .set(kullanici.toMap());
    return true;
  }

  @override
  Future<Kullanici> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firestore.collection('users').doc(userID).get();
    return Kullanici.fromMap(_okunanUser.data());
  }

  @override
  Future<bool> updateUserName(String userID, String newUserName) async {
    var users = await _firestore
        .collection("users")
        .where("userName", isEqualTo: newUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firestore
          .collection("users")
          .doc(userID)
          .update({'userName': newUserName});
      return true;
    }
  }

  @override
  Future<bool> updateProfilFoto(String userID, String profilUrl) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .update({'profilUrl': profilUrl});
    return true;
  }

  @override
  Future<List<Mekan>> getMekanlar(String sehir, String tur) async {
    if (sehir == null && tur == null) {
      QuerySnapshot querySnapshot =
          await _firestore.collection("mekanlar").get();
      List<Mekan> tumMekanlar = [];
      for (DocumentSnapshot tekMekan in querySnapshot.docs) {
        Mekan mekan = Mekan.fromMap(tekMekan.data());
        mekan.id = tekMekan.id;
        tumMekanlar.add(mekan);
      }
      return tumMekanlar;
    } else if (sehir != null && tur == null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection("mekanlar")
          .where('sehir', isEqualTo: sehir)
          .get();
      List<Mekan> tumMekanlar = [];
      for (DocumentSnapshot tekMekan in querySnapshot.docs) {
        Mekan mekan = Mekan.fromMap(tekMekan.data());
        mekan.id = tekMekan.id;
        tumMekanlar.add(mekan);
      }

      return tumMekanlar;
    } else if (sehir == null && tur != null) {
      QuerySnapshot querySnapshot;
      if (tur == "Tümü") {
        querySnapshot = await _firestore.collection("mekanlar").get();
      } else {
        querySnapshot = await _firestore
            .collection("mekanlar")
            .where('tur', isEqualTo: tur)
            .get();
      }
      List<Mekan> tumMekanlar = [];
      for (DocumentSnapshot tekMekan in querySnapshot.docs) {
        Mekan mekan = Mekan.fromMap(tekMekan.data());
        mekan.id = tekMekan.id;
        tumMekanlar.add(mekan);
      }

      return tumMekanlar;
    } else {
      QuerySnapshot querySnapshot;
      if (tur == "Tümü") {
        querySnapshot = await _firestore
            .collection("mekanlar")
            .where('sehir', isEqualTo: sehir)
            .get();
      } else {
        querySnapshot = await _firestore
            .collection("mekanlar")
            .where('tur', isEqualTo: tur)
            .where('sehir', isEqualTo: sehir)
            .get();
      }
      List<Mekan> tumMekanlar = [];
      for (DocumentSnapshot tekMekan in querySnapshot.docs) {
        Mekan mekan = Mekan.fromMap(tekMekan.data());
        mekan.id = tekMekan.id;
        tumMekanlar.add(mekan);
      }

      return tumMekanlar;
    }
  }

  @override
  Future<bool> addFav(String userID, String mekanID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('favoriler')
        .where('userID', isEqualTo: userID)
        .where('mekanID', isEqualTo: mekanID)
        .get();
    if (querySnapshot.docs.length > 0) {
      return false;
    } else {
      await _firestore
          .collection('favoriler')
          .add({'userID': userID, 'mekanID': mekanID});
      return true;
    }
  }

  @override
  Future<List<Mekan>> getFav(String userID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('favoriler')
        .where('userID', isEqualTo: userID)
        .get();
    List<Favoriler> favoriler = [];
    for (DocumentSnapshot tekFav in querySnapshot.docs) {
      Favoriler mekan = Favoriler.fromMap(tekFav.data());
      favoriler.add(mekan);
    }
    List<Mekan> favMekanlar = [];
    for (Favoriler tekmekan in favoriler) {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('mekanlar').doc(tekmekan.mekanID).get();
      Mekan mekan = Mekan.fromMap(documentSnapshot.data());
      mekan.id = tekmekan.mekanID;
      favMekanlar.add(mekan);
    }

    return favMekanlar;
  }

  @override
  Future<bool> deleteFav(String userID, String mekanID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('favoriler')
        .where('userID', isEqualTo: userID)
        .where('mekanID', isEqualTo: mekanID)
        .get();

    for (DocumentSnapshot silinecek in querySnapshot.docs) {
      await _firestore.collection('favoriler').doc(silinecek.id).delete();
    }
    return null;
  }

  @override
  Future<bool> favKontrol(String userID, String mekanID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('favoriler')
        .where('userID', isEqualTo: userID)
        .where('mekanID', isEqualTo: mekanID)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> BegeniKontrol(String userID, String mekanID) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('Begeniler')
        .doc(userID)
        .collection('mekanlar')
        .doc(mekanID)
        .get();

    if (documentSnapshot.data() != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> addBegen(String userID, String mekanID) async {
    await _firestore
        .collection('Begeniler')
        .doc(userID)
        .collection('mekanlar')
        .doc(mekanID)
        .set({'mekanId': mekanID});
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('mekanlar').doc(mekanID).get();
    int a = documentSnapshot.data()['begeniSayisi'];
    a++;
    await _firestore
        .collection('mekanlar')
        .doc(mekanID)
        .update({'begeniSayisi': a});
    return null;
  }

  @override
  Future<bool> deleteBegen(String userID, String mekanID) async {
    await _firestore
        .collection('Begeniler')
        .doc(userID)
        .collection('mekanlar')
        .doc(mekanID)
        .delete();

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('mekanlar').doc(mekanID).get();
    int a = documentSnapshot.data()['begeniSayisi'];
    a--;
    await _firestore
        .collection('mekanlar')
        .doc(mekanID)
        .update({'begeniSayisi': a});
    return null;
  }

  @override
  Future<bool> addYorum(Yorum yorum) async {
    await _firestore
        .collection("Yorumlar")
        .doc(yorum.mekanID)
        .collection('yorumlar')
        .add(yorum.toMap());
    return true;
  }

  @override
  Future<bool> deleteYorum(String yorumID, String mekanID) async {
    await _firestore
        .collection("Yorumlar")
        .doc(mekanID)
        .collection('yorumlar')
        .doc(yorumID)
        .delete();

    return null;
  }

  @override
  Future<List<Yorum>> getYorumlar(String mekanID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("Yorumlar")
        .doc(mekanID)
        .collection('yorumlar')
        .orderBy('date', descending: false)
        .get();

    /*
    QuerySnapshot querySnapshot = await _firestore
        .collection("Yorumlar")
        .doc(mekanID)
        .collection('yorumlar')
        .get();
     */

    List<Yorum> tumYorumlar = [];
    for (DocumentSnapshot tekYorum in querySnapshot.docs) {
      Yorum yorum = Yorum.fromMap(tekYorum.data());
      yorum.id = tekYorum.id;
      tumYorumlar.add(yorum);
    }
    return tumYorumlar;
  }
}
