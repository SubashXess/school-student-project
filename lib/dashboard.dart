import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmajg/Widgets/background.dart';
import 'package:pmajg/Widgets/phase_button_widget.dart';
import 'package:pmajg/image_preview_screen.dart';
import 'package:pmajg/user_type.dart';
import 'package:pmajg/verify_page.dart';

import 'Constants/ColorConstants.dart';
import 'MySharedPreferences.dart';
import 'dao/DatabaseHelper22.dart';
import 'dao/dio_upload_service.dart';
import 'dao/http_upload_service.dart';
import 'loader.dart';

class DashboardPage extends StatefulWidget {
//int status;
  DashboardPage() : super();
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  //final HttpUploadService _httpUploadService = HttpUploadService();
  //final DioUploadService _dioUploadService = DioUploadService();
  //String img1,img2,img3;
  String? reg_id, name, mobile;
  //final dbHelper = DatabaseHelper22.instance;
  bool servicestatus = false;
  bool haspermission = false;
  // LocationPermission permission;
  // String _scanBarcode = 'Unknown';
  // Position position;
  // String long = "", lat = "";
  // StreamSubscription<Position> positionStream;
  // CameraDescription _cameraDescription;
  List<String> _images = [];
  String imagePath = '';
  // String base64String;
  // String selectedKhataNo,selectedPlotNo;
  bool isPressed = false;
  Color selectedPlotColor = const Color(0xff034B03);
  // String ref_ws;
  // int _selectedIndex;
  int status4 = 0;
  int maxStatus = 0;
  //int reportCount;
  StreamController<int> streamController = new StreamController<int>();
  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getStringValue("REG")
        .then((value) => setState(() {
              reg_id = value;
            }));
    MySharedPreferences.instance
        .getStringValue("MOB")
        .then((value) => setState(() {
              mobile = value;
            }));
    MySharedPreferences.instance
        .getStringValue("NAME")
        .then((value) => setState(() {
              name = value;
            }));
  }

  Future<void> logoutUser() async {
    MySharedPreferences.instance.removeAll();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserType()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: kToolbarHeight * 1.4,
        title: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Text(
                'Beneficiary ',
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              Text(
                name.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Text(
                '( Mob : ' + mobile.toString() + ' )',
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        backgroundColor: ColorConstants.kPrimaryColor,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(child: Text("Logout"), value: 0),
              // PopupMenuItem(
              //     child: Text("New Group Chat"), value: "/new-group-chat"),
              //PopupMenuItem(child: Text("Settings"), value: "/settings"),
            ],
            onSelected: (route) {
              if (route == 0) {
                logoutUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserType()),
                );
              }
            },
          ),
        ],
      ),
      // backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Background(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: PhaseButtonWidget(
                  size: size,
                  label: label[index],
                  viewbtn: 'View',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyPage(
                          label[index].toString(),
                        ),
                      ),
                    );
                  },
                  onPressedView: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePreviewScreen(
                          appbartitle: label[index].toString(),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  final List<String> label = [
    'Phase One',
    'Phase Two',
    'Phase Three',
  ];
}
