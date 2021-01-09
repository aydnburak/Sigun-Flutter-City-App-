import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_city_app/model/kullanici.dart';
import 'package:flutter_city_app/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSingIn = GoogleSignIn();

  @override
  Future<Kullanici> currentUser() async {
    User user =  _firebaseAuth.currentUser;
    return _kullaniciFromFirebase(user);
  }

  Kullanici _kullaniciFromFirebase(User user) {
    if (user == null) return null;
    return Kullanici(userID: user.uid,email: user.email);
  }

  @override
  Future<bool> singOut() async {
    await _googleSingIn.signOut();
    await _firebaseAuth.signOut();

    return null;
  }

  @override
  Future<Kullanici> singInWithGoogle() async {
    GoogleSignInAccount _googleUser = await _googleSingIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User _user = sonuc.user;
        Kullanici _kullanici=_kullaniciFromFirebase(_user);
        _kullanici.userName=_user.displayName;
        _kullanici.profilUrl=_user.photoURL;
        return _kullanici;
      }
    }
    return null;
  }

  @override
  Future<Kullanici> singInWithEmailAndPassword(String email, String sifre) async{
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
    return _kullaniciFromFirebase(credential.user);
  }

  @override
  Future<Kullanici> createUserWithEmailAndPassword(String email, String sifre,adSoyad) async{
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _kullaniciFromFirebase(credential.user);


  }

  
}
