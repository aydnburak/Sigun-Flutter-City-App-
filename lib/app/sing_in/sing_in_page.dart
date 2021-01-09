import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_city_app/app/sing_in/hata_exception.dart';
import 'package:flutter_city_app/main.dart';
import 'package:flutter_city_app/viewmodel/user_model.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

enum FormType { Register, LogIn }

class SingInPage extends StatefulWidget {
  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  String _adSoyad, _email, _sifre, _butonText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<FormState>();

  void _googleIleGiris() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await _userModel.singInWithGoogle();
  }

  void _formSubmit() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formType == FormType.LogIn) {
      try {
        await _userModel.singInWithEmailAndPassword(_email, _sifre);
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Giriş Hatası"),
                content: Text(Hatalar.goster(e.code)),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Tamam"))
                ],
              );
            });
      }
    } else {
      try {
        await _userModel.createUserWithEmailAndPassword(
            _email, _sifre, _adSoyad);
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Kullanıcı Oluşturma Hatası"),
                content: Text(Hatalar.goster(e.code)),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Tamam"))
                ],
              );
            });
      }
    }
  }

  Widget _loading() {
    final _userModel = Provider.of<UserModel>(context);
    return _userModel.state == ViewState.Busy
        ? Container(
            width: 75,
            height: 75,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SizedBox();
  }

  Widget _girisButtonu() {
    return Container(
      height: 75,
      padding: EdgeInsets.only(top: 30),
      child: RaisedButton(
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: MyApp.temaColorBlack, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        //elevation: 15,
        color: MyApp.temaColorHomeGreen,
        onPressed: () => _formSubmit(),
        child: Text(
          _butonText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: MyApp.temaColorGrey),
        ),
      ),
    );
  }

  Widget _googleGirisButtonu() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Center(
          child: SignInButton(
            Buttons.Google,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),

            ),
            padding: EdgeInsets.all(10),
            onPressed: () => _googleIleGiris(),
          ),
        ),
      ],
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _formType == FormType.Register
              ? TextFormField(
            style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: MyApp.temaColorBlack,
                      prefixIcon: Icon(Icons.person_outline,color: Colors.white,),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                      labelText: "Ad Soyad",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  onSaved: (String adSoyad) {
                    _adSoyad = adSoyad;
                  },
                )
              : SizedBox(),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.white),

            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              focusColor: Colors.white,
              filled: true,
              fillColor: MyApp.temaColorBlack,
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
              labelText: "E-posta",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            onSaved: (String girilenEmail) {
              _email = girilenEmail;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: MyApp.temaColorBlack,
                prefixIcon: Icon(Icons.lock,color: Colors.white,),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
                labelText: "Parola",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            onSaved: (String girilenSifre) {
              _sifre = girilenSifre;
            },
          ),
        ],
      ),
    );
  }

  Widget _gecisText() {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: FlatButton(
          onPressed: () {
            setState(() {
              if (_formType == FormType.LogIn) {
                _formType = FormType.Register;
              } else {
                _formType = FormType.LogIn;
              }
            });
          },
          child: Text(_linkText,style: TextStyle(color:Colors.white),)),
    );
  }

  Widget _logo(double genislik, double yukseklik) {
    return Image.asset(
      "assets/logo/logo_yazili.png",
      width: genislik * 0.75,
      height: yukseklik * 0.35,
    );
  }

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.LogIn ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.LogIn
        ? "Hesabınız Yok Mu? Kayıt Olun"
        : "Hesabınız Var Mı? Giriş Yapın";
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyApp.temaColorBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _logo(genislik, yukseklik),
              _form(),
              _girisButtonu(),
              _loading(),

              _googleGirisButtonu(),
              _gecisText(),
            ],
          ),
        ),
      ),
    );
  }
}
