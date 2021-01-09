import 'package:flutter_city_app/model/kullanici.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/model/yorum.dart';

abstract class DBBase {
  Future<bool> saveUser(Kullanici kullanici);

  Future<bool> updateUserName(String userID, String newUserName);

  Future<Kullanici> readUser(String userID);

  Future<List<Mekan>> getMekanlar(String sehir, String tur);

  Future<List<Mekan>> getFav(String userID);

  Future<bool> addFav(String userID, String mekanID);

  Future<bool> deleteFav(String userID, String mekanID);

  Future<bool> favKontrol(String userID, String mekanID);

  Future<bool> addBegen(String userID, String mekanID);

  Future<bool> deleteBegen(String userID, String mekanID);

  Future<bool> BegeniKontrol(String userID, String mekanID);

  Future<List<Yorum>> getYorumlar(String mekanID);

  Future<bool> addYorum(Yorum yorum);

  Future<bool> deleteYorum(String yorumID, String mekanID);

}
