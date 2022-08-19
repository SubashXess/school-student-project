import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'MySharedPreferences.dart';
import 'constants/ColorConstants.dart';
import 'loginpage.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class UserType extends StatefulWidget {
  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool visible = false ;
  bool hasError = false;
  String currentText = "";
  bool showLoading = false;
  @override
  void initState() {
    super.initState();
  }
  getMobileFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        const Text(
          "Welcome to,",
          textAlign:  TextAlign.left,
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.w500),
        ),
        const Text(
          "PMAJ-G",
          textAlign:  TextAlign.left,
          style: TextStyle(
              fontFamily: 'Roboto',
              color: ColorConstants.kPrimaryColor,
              fontSize: 40.0,
              fontWeight: FontWeight.w700),
        ),


        // TextField(
        //   controller: phoneController,
        //   decoration: InputDecoration(
        //     hintText: "Phone Number",
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 200,
          height: 200,
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   image: DecorationImage(
          //       image: new AssetImage("assets/images/pmaj.png"),
          //       fit: BoxFit.fill
          //   ),
          // ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget>[
              GestureDetector(
                onTap: () async {
                  // setState(() {
                  //   showLoading = true;
                  // });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const LoginPage()),
                  );
                },
                child:Container(
                  height: 70,
                  width: 165,
                  margin: const EdgeInsets.only(left: 10),
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    ),
                    color: ColorConstants.kPrimaryColor,
                  ),
                  child: const Center(
                    child:Text("Beneficiary Login",style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      // color: const Color(0xff17278d),
                      //color: Colors.deepPurple,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () async {
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DashboardPage()
                  //     ),
                  //     ModalRoute.withName("/Home")
                  // );
                  //await loginAction();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>
                  //       DashboardPage()),
                  // );
                },
                child:Container(
                  height: 70,
                  width: 165,
                  margin: const EdgeInsets.only(right: 10),
                  decoration:const BoxDecoration(
                    color:  ColorConstants.kPrimaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: const Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: const Radius.circular(10),
                        bottomLeft: const Radius.circular(10)
                    ),
                  ),
                  child: const Center(
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [])
                    child:const Text("Reviewer Login",style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      // color: const Color(0xff17278d),
                      //color: Colors.deepPurple,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                      textAlign: TextAlign.center,
                    ),),
                ),),
            ]
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DashboardPage()
            //     ),
            //     ModalRoute.withName("/Home")
            // );
            //await loginAction();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) =>
            //       DashboardPage()),
            // );
          },
          child:Container(
            height: 70,
            margin: const EdgeInsets.only(left:10,right: 10),
            padding: const EdgeInsets.only(left: 10,right: 10),
            decoration:const BoxDecoration(
              color:  ColorConstants.kPrimaryColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
              ),
            ),
            child: const Center(
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [])
              child:const Text("Guidelines for PMAY-G",style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Roboto',
                fontSize: 20,
                // color: const Color(0xff17278d),
                //color: Colors.deepPurple,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
                textAlign: TextAlign.center,
              ),),
          ),),
        const Spacer(),
      ],
    );
  }
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: getMobileFormWidget(context)
    );
  }
//OTP CODE
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         child: showLoading
//             ? Center(
//           child: Loader(),
//         )
//             : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
//             ? getMobileFormWidget(context)
//             : userLogin(phoneController.text),
//         padding: const EdgeInsets.all(16),
//       ));
// }
}
