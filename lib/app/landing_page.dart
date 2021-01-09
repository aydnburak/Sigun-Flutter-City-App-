import 'package:flutter/material.dart';
import 'package:flutter_city_app/app/home_page.dart';
import 'package:flutter_city_app/app/sing_in/sing_in_page.dart';
import 'package:flutter_city_app/viewmodel/mekan_model.dart';
import 'package:flutter_city_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);


    if (_userModel.state == ViewState.idle) {
      if (_userModel.kullanici == null) {
        return SingInPage();
      } else {
        final mekanModel = Provider.of<MekanModel>(context);
        mekanModel.UserID=_userModel.kullanici.userID;
        return HomePage();
      }
    } else {
      return SingInPage();
    }
  }
}
