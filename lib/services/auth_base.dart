import 'package:flutter_city_app/model/kullanici.dart';

abstract class AuthBase{
  Future<Kullanici> currentUser();
  Future<bool> singOut();
  Future<Kullanici> singInWithGoogle();
  Future<Kullanici> singInWithEmailAndPassword(String email,String sifre);
  Future<Kullanici> createUserWithEmailAndPassword(String email,String sifre,String adSoyad);

}