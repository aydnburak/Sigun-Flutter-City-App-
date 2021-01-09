import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_city_app/locator.dart';
import 'package:flutter_city_app/model/kullanici.dart';
import 'package:flutter_city_app/repository/user_repository.dart';
import 'package:flutter_city_app/services/auth_base.dart';

enum ViewState { idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;
  UserRepository _userRepository = locator<UserRepository>();
  Kullanici _kullanici;

  Kullanici get kullanici => _kullanici;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<Kullanici> currentUser() async {
    state = ViewState.Busy;
    _kullanici = await _userRepository.currentUser();
    state = ViewState.idle;
    return _kullanici;
  }

  @override
  Future<bool> singOut() async {
    state = ViewState.Busy;
    bool sonuc = await _userRepository.singOut();
    _kullanici = null;
    state = ViewState.idle;
    return sonuc;
  }

  @override
  Future<Kullanici> singInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _kullanici = await _userRepository.singInWithGoogle();

      return _kullanici;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<Kullanici> singInWithEmailAndPassword(
      String email, String sifre) async {
    try {
      state = ViewState.Busy;
      _kullanici =
          await _userRepository.singInWithEmailAndPassword(email, sifre);

      return _kullanici;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(
      String email, String sifre,String adSoyad) async {
    try {
      state = ViewState.Busy;
      _kullanici =
          await _userRepository.createUserWithEmailAndPassword(email, sifre,adSoyad);
      return _kullanici;
    } finally {
      state = ViewState.idle;
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var sonuc = await _userRepository.updateUserName(userID, yeniUserName);
    if (sonuc) _kullanici.userName = yeniUserName;

    return sonuc;
  }

  Future<String> updateFile(
      String userID, String fileType, File profilFoto) async {
    String sonuc =
        await _userRepository.updateFile(userID, fileType, profilFoto);
    _kullanici.profilUrl = sonuc;
    return sonuc;

  }
}
