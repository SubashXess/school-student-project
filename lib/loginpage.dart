// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pmajg/Widgets/background.dart';
import 'package:pmajg/dashboard.dart';
import 'package:pmajg/verify_page.dart';

import 'Constants/ApiConstant.dart';
import 'package:http/http.dart' as http;

import 'Constants/ColorConstants.dart';
import 'MySharedPreferences.dart';
import 'Validators/textformfield_validation.dart';
import 'Widgets/rounded_button_widget.dart';
import 'Widgets/textformfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _registrationController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  bool _isHidePassword = true;
  bool visible = false;
  @override
  void initState() {
    _mobileController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _registrationController.dispose();
    _mobileController.removeListener(onListen);
    _mobileController.dispose();
  }

  void onListen() {
    setState(() {});
  }

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    String p_reg = _registrationController.text;
    String p_mob = _mobileController.text;
    // print('Email : $email Password : $password');
    // SERVER LOGIN API URL
    var url = ApiConstant.api1 + 'login.php';
    var response = await http.post(Uri.parse(url), body: {
      "reg_id": p_reg,
      "mobile": p_mob,
    });
    // Getting Server response into variable.
    print(response.body.toString());
    var message = jsonDecode(response.body);
    String id = message[0]['user_id'];
    String reg = message[0]['reg_id'];
    String name = message[0]['name'];
    String mobile = message[0]['mobile'];
    //String password=message[0]['password'];
    print('MOB : ' + mobile);
    //String password=message['password'];
    if (p_reg == reg || p_mob == mobile) {
      MySharedPreferences.instance.setStringValue("REG", reg);
      MySharedPreferences.instance.setStringValue("MOB", mobile);
      MySharedPreferences.instance.setStringValue("NAME", name);
      MySharedPreferences.instance.setBooleanValue("loggedin", true);
      //Navigator.of(context).pushNamed('/dashboard_page');
      // Hiding the CircularProgressIndicator.
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardPage()));
      setState(() {
        visible = false;
      });
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message["message"]),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //         'assets/images/login.jpg'),
          //     fit: BoxFit.contain,
          //   ),
          // ),
          child: SafeArea(
            child: Background(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    child: Form(
                      key: _formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: ColorConstants.kPrimaryLightColor1,
                                  width: 1.0,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 20.0,
                                color: ColorConstants.kSecondaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Center(
                              // child:Container(
                              //   width: 200,
                              //   height: 200,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     image: DecorationImage(
                              //         image: new AssetImage("assets/images/pmaj.png"),
                              //         fit: BoxFit.fill
                              //     ),
                              //   ),
                              // ),),
                              SizedBox(height: size.height * 0.016),
                              const Text(
                                "PMAJ-G",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: ColorConstants.kSecondaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // SizedBox(height: size.height * 0.016),
                              // const Text(
                              //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: 16.0,
                              //     color: ColorConstants.kSecondaryLightColor,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.040),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormFieldWidget(
                                controller: _registrationController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: "Registration ID",
                                labelColor:
                                    ColorConstants.kPrimaryColor.withAlpha(160),
                                borderColor:
                                    ColorConstants.kPrimaryUltraLightColor,
                                bgColor: ColorConstants.kPrimaryUltraLightColor,
                                //validator: TextFieldValidation.userMobileValidation,
                                inputType: TextInputType.text,
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                              SizedBox(height: size.height * 0.012),
                              Text(
                                'OR',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height * 0.012),
                              TextFormFieldWidget(
                                controller: _mobileController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: "Mobile No",
                                labelColor:
                                    ColorConstants.kPrimaryColor.withAlpha(160),
                                borderColor:
                                    ColorConstants.kPrimaryUltraLightColor,
                                bgColor: ColorConstants.kPrimaryUltraLightColor,
                                //validator: TextFieldValidation.userMobileValidation,
                                inputType: TextInputType.number,
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                              SizedBox(height: size.height * 0.016),
                              RoundedButtonWidget(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => VerifyPage()),
                                  // );
                                  // if (_formKey.currentState!.validate()) {
                                  //   // Navigator.of(context)
                                  //   //     .pushNamed('dashboard_page');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                        Color>(
                                                    ColorConstants
                                                        .kPrimaryColor),
                                          ),
                                        );
                                      });
                                  userLogin();
                                  // } else {
                                  //   print("Error");
                                  // }
                                },
                                label: "Login",
                                bgColor: ColorConstants.kPrimaryColor,
                                labelColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }
}
