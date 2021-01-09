import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_city_app/app/landing_page.dart';
import 'package:flutter_city_app/deneme.dart';
import 'package:flutter_city_app/locator.dart';
import 'package:flutter_city_app/viewmodel/mekan_model.dart';
import 'package:flutter_city_app/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

void main() async {
  Color temaColorHomeGreen = Color(0xFF49824D);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: temaColorHomeGreen, // navigation bar color
    statusBarColor: temaColorHomeGreen, // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Color temaColorGreen = Color(0xFF71DB77);
  static Color temaColorGrey = Color(0xFFD9D9D9);
  static Color temaColorBlack = Color(0xFF1A1A1A);
  static Color temaColorHomeGreen = Color(0xFF49824D);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: ChangeNotifierProvider(
          create: (context) => MekanModel(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sigun',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: LandingPage(),
            //home: Deneme(),
          ),
        ));
  }
}
/*
MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter City App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ChangeNotifierProvider(
            create: (context) => MekanModel(),
            //child: Deneme()),
            child: LandingPage()),

      ),
 */
