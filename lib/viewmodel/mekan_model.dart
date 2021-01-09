import 'package:flutter/material.dart';
import 'package:flutter_city_app/locator.dart';
import 'package:flutter_city_app/model/mekan.dart';
import 'package:flutter_city_app/model/yorum.dart';
import 'package:flutter_city_app/repository/user_repository.dart';

enum Durum { Bosta, Dolu }

class MekanModel with ChangeNotifier {
  String UserID;
  String sehir;
  String tur;
  String MekanID;
  String YorumID;
  Yorum yorum;

  List<Mekan> mekanlar = [];
  List<Mekan> favmekanlar = [];
  List<Yorum> yorumlar = [];
  Durum _durum = Durum.Bosta;
  UserRepository _userRepository = locator<UserRepository>();

  set durum(Durum value) {
    _durum = value;
    notifyListeners();
  }

  MekanModel() {
    getMekanlar();
    getFav();
  }

  Future<List<Mekan>> getMekanlar() async {
    durum = Durum.Dolu;
    mekanlar = await _userRepository.getMekanlar(sehir, tur);
    durum = Durum.Bosta;
    return mekanlar;
  }

  Future<List<Mekan>> getFav() async {
    durum = Durum.Dolu;
    favmekanlar = await _userRepository.getFav(UserID);
    durum = Durum.Bosta;
    return favmekanlar;
  }

  Future<bool> addFav(String userID, String mekanID) async {
    bool sonuc = await _userRepository.addFav(userID, mekanID);
    getFav();
    return sonuc;
  }

  Future<bool> deleteFav(String userID, String mekanID) async {
    bool sonuc = await _userRepository.deleteFav(userID, mekanID);
    getFav();
    return sonuc;
  }

  Future<bool> favKontrol(String userID, String mekanID) async {
    return await _userRepository.favKontrol(userID, mekanID);
  }

  Future<bool> addBegen(String userID, String mekanID) async {
    return await _userRepository.addBegen(userID, mekanID);
  }

  Future<bool> deleteBegen(String userID, String mekanID) async {
    return await _userRepository.deleteBegen(userID, mekanID);
  }

  Future<bool> BegeniKontrol(String userID, String mekanID) async {
    return await _userRepository.BegeniKontrol(userID, mekanID);
  }

  Future<List<Yorum>> getYorumlar() async {
    yorumlar = await _userRepository.getYorumlar(MekanID);
    return yorumlar;
  }

  Future<bool> addYorum() async {
    return await _userRepository.addYorum(yorum);
  }

  Future<bool> deleteYorum() async {
    bool sonuc = await _userRepository.deleteYorum(YorumID, MekanID);
    await getYorumlar();
    return sonuc;
  }
}
