import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pmajg/Constants/ColorConstants.dart';
import 'package:pmajg/user_type.dart';
import 'package:pmajg/verify_page.dart';
import '../MySharedPreferences.dart';
import 'dashboard.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static String mob = "";
  bool isLoggedIn = false;
  SplashScreenState() {
    MySharedPreferences.instance
        .getBooleanValue("loggedin")
        .then((value) => setState(() {
              isLoggedIn = value;
              //print('Splashscreen Pref :'+mob1.toString());
            }));
  }
  @override
  void initState() {
    super.initState();
    new Timer(new Duration(seconds: 5), () {
      check();
    });
  }

  Future check() async {
    print('STATUS CHK :' + isLoggedIn.toString());
    if (isLoggedIn == false) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => UserType()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardPage()));
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => NewAddress('AC','200')));
    }
  }

  // _configureFirebaseListeners() {
  //   _firebaseMessaging.subscribeToTopic('all');
  //
  //   _firebaseMessaging.configure(onMessage: (message) async {
  //     print('onMessage ${json.encode(message)}');
  //   }, onResume: (message) async {
  //     print('onResume $message');
  //   }, onLaunch: (message) async {
  //     print('onLaunch $message');
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
