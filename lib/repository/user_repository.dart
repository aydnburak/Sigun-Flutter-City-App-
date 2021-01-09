import 'dart:io';

import 'package:flutter_city_app/locator.dart';
import 'package:flutter_city_app/model/kullanici.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/model/yorum.dart';
import 'package:flutter_city_app/services/auth_base.dart';
import 'package:flutter_city_app/services/firebase_auth_service.dart';
import 'package:flutter_city_app/services/firebase_storage_service.dart';
import 'package:flutter_city_app/services/firestore_db_service.dart';

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService = locator<FirebaseStorageService>();

  @override
  Future<Kullanici> currentUser() async {
    Kullanici _kullanici = await _firebaseAuthService.currentUser();
    if (_kullanici != null) {
      return _firestoreDBService.readUser(_kullanici.userID);
    }
    return _kullanici;
  }

  @override
  Future<bool> singOut() async {
    return await _firebaseAuthService.singOut();
  }

  @override
  Future<Kullanici> singInWithGoogle() async {
    Kullanici _kullanici = await _firebaseAuthService.singInWithGoogle();

    bool _sonuc = await _firestoreDBService.saveUser(_kullanici);
    if (_sonuc) {
      return await _firestoreDBService.readUser(_kullanici.userID);
    } else {
      return null;
    }
  }

  @override
  Future<Kullanici> singInWithEmailAndPassword(
      String email, String sifre) async {
    Kullanici _kullanici =
        await _firebaseAuthService.singInWithEmailAndPassword(email, sifre);
    return await _firestoreDBService.readUser(_kullanici.userID);
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(
      String email, String sifre,adSoyad) async {
    Kullanici _kullanici =
        await _firebaseAuthService.createUserWithEmailAndPassword(email, sifre,adSoyad);
    _kullanici.userName=adSoyad;
    bool _sonuc = await _firestoreDBService.saveUser(_kullanici);
    if (_sonuc) {
      return await _firestoreDBService.readUser(_kullanici.userID);
    } else {
      return null;
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName)async {
    return await _firestoreDBService.updateUserName(userID, yeniUserName);
  }

  Future<String> updateFile(String userID, String fileType, File profilFoto) async{
    String url= await _firebaseStorageService.uploadFile(userID, fileType, profilFoto);
    await _firestoreDBService.updateProfilFoto(userID,url);

    return url;
  }

  Future<List<Mekan>> getMekanlar(String sehir, String tur)async {
    return await _firestoreDBService.getMekanlar(sehir,tur);
  }

  Future<List<Mekan>> getFav(String userID) async{
    return await _firestoreDBService.getFav(userID);
  }

  Future<bool> addFav(String userID, String mekanID) async{
    return await _firestoreDBService.addFav(userID, mekanID);
  }

  Future<bool> deleteFav(String userID, String mekanID) async{
    return await _firestoreDBService.deleteFav(userID, mekanID);
  }

  Future<bool> favKontrol(String userID, String mekanID) async{
    return await _firestoreDBService.favKontrol(userID, mekanID);
  }

  Future<bool> addBegen(String userID, String mekanID) async{
    return await _firestoreDBService.addBegen(userID, mekanID);
  }

  Future<bool> deleteBegen(String userID, String mekanID) async{
    return await _firestoreDBService.deleteBegen(userID, mekanID);
  }

  Future<bool> BegeniKontrol(String userID, String mekanID) async{
    return await _firestoreDBService.BegeniKontrol(userID, mekanID);
  }

  Future<List<Yorum>> getYorumlar(String mekanID) async{
    return await _firestoreDBService.getYorumlar(mekanID);
  }

  Future<bool> addYorum(Yorum yorum) async{
    return await _firestoreDBService.addYorum(yorum);
  }

  Future<bool> deleteYorum(String yorumID, String mekanID) async{
    return await _firestoreDBService.deleteYorum(yorumID, mekanID);
  }
}
