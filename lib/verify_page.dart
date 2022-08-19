import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmajg/Widgets/background.dart';
import 'package:pmajg/user_type.dart';
import 'package:sqflite/sqflite.dart';
import 'Constants/ColorConstants.dart';
import 'FullScreenImage.dart';
import 'MySharedPreferences.dart';
import 'Utility.dart';
import 'dao/DatabaseHelper22.dart';
import 'dao/dio_upload_service.dart';
import 'dao/http_upload_service.dart';
import 'package:path/path.dart';
import 'loader.dart';
import 'model/Photo.dart';

class VerifyPage extends StatefulWidget {
  String? status;
  VerifyPage(this.status) : super();
  @override
  _VerifyPageState createState() => _VerifyPageState(status!);
}

class _VerifyPageState extends State<VerifyPage>
    with SingleTickerProviderStateMixin {
  final HttpUploadService _httpUploadService = HttpUploadService();
  final ScrollController _scrollController = ScrollController();
  //final DioUploadService _dioUploadService = DioUploadService();
  String? status;
  //String img1,img2,img3;
  String? reg_id, name, mobile;
  final dbHelper = DatabaseHelper22.instance;
  // Database dbHelper = DatabaseHelper22();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  //CameraDescription _cameraDescription;
  late List<String> _images = [];
  String? imagePath = '';
  String? base64String;
  String? selectedKhataNo, selectedPlotNo;
  bool isPressed = false;
  Color selectedPlotColor = const Color(0xff034B03);
  String? ref_ws;
  int? status4 = 0;
  int? maxStatus = 0;
  int? reportCount;
  String img22 =
      '/data/user/0/com.example.pmajg/app_flutter/f13585f2-eeaf-4716-9521-9a844ddb3e186441900169818777250.jpg';
  File? image1, image2, image3;
  String? loadImage1, loadImage2, loadImage3;
  String?
      loadName; // Name Text Box Load the first name and last name to this variable
  String? loadPhone; // Phone Text Box load the phone
  String? loadPassword; // Password Text Box load the password
  bool? visible = false;
  late List<Photo> images;
  late StreamController<int> streamController = new StreamController<int>();
  _VerifyPageState(this.status);
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
    images = [];
    refreshImages();
    checkGps();
    // availableCameras().then((cameras) {
    //   final camera = cameras
    //       .where((camera) => camera.lensDirection == CameraLensDirection.back)
    //       .toList()
    //       .first;
    //   setState(() {
    //     _cameraDescription = camera;
    //   });
    // }).catchError((err) {
    //   print(err);
    // });
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
    print('latlang :' + lat + ' ' + long);
    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
      print('LAT & LANG :' + long + ' ' + lat);
      setState(() {
        //refresh UI on update
      });
    });
  }

  void presentLoader(BuildContext context,
      {String text = 'Aguarde...',
      bool barrierDismissible = false,
      bool willPop = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async {
              return willPop;
            },
            child: AlertDialog(
              content: Row(
                children: <Widget>[
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> presentAlert(BuildContext context,
      {String title = '', String message = '', Function()? ok}) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Text(message)],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  // style: greenText,
                ),
                onPressed: ok ?? Navigator.of(context).pop,
              ),
            ],
          );
        });
  }

  _onSelected(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });
  }
  // void _inset_verify(Photo image) async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DatabaseHelper22.IMAGE : image
  //   };
  //   final db = await dbHelper.database;
  //   // final id=await db.rawInsert("INSERT Into verification (ref_id,name,khata_no,plot_no,image,status,lat,lang)"
  //   // " VALUES ($image)");
  //   final id = await DatabaseHelper22.instance.save(row);
  //   print('upload inserted row : $id');
  // }
  // void _updateStatus(String ref_id,String status)
  // {
  //   DatabaseHelper22.instance.updateStatus(ref_id, status);
  // }
  Future<void> logoutUser(BuildContext context) async {
    MySharedPreferences.instance.removeAll();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserType()));
  }

  Future pickImage1(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      // temporary image
      // final imageTemporary = File(image.path);

      // permanent image
      final imagePermanent = await saveImagePermanently1(image.path);

      setState(() {
        // this.image = imageTemporary;
        this.image1 = imagePermanent;
        loadImage1 = imagePermanent.toString();
        // ignore: avoid_print
        print("Load Image : $loadImage1");
        Photo photo = Photo(0, loadImage1);
        dbHelper.save(photo);
        //Navigator.of(context).pop();
        print('Photo 1 : $photo');
        print('DbPhot : ${dbHelper.save(photo)}');
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image : $e');
    }
  }

  Future<File> saveImagePermanently1(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future pickImage2(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      // temporary image
      // final imageTemporary = File(image.path);

      // permanent image
      final imagePermanent = await saveImagePermanently2(image.path);

      setState(() {
        // this.image = imageTemporary;
        this.image2 = imagePermanent;
        loadImage2 = imagePermanent.toString();
        // ignore: avoid_print
        print("Load Image : $loadImage2");
        //Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image : $e');
    }
  }

  Future<File> saveImagePermanently2(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future pickImage3(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      // temporary image
      // final imageTemporary = File(image.path);

      // permanent image
      final imagePermanent = await saveImagePermanently3(image.path);

      setState(() {
        // this.image = imageTemporary;
        this.image3 = imagePermanent;
        loadImage3 = imagePermanent.toString();
        // ignore: avoid_print
        print("Load Image : $loadImage3");
        //Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image : $e');
    }
  }

  Future<File> saveImagePermanently3(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  _nameOnChanged(String? name) {
    loadName = name!.trim().toString().replaceAll(' ', '');
    // ignore: avoid_print
    print(loadName);
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  gridView() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return Utility.imageFromBase64String(photo.image!);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('Rebuild');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        // ),
        title: Text(
          status ?? 'NA',
          style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        backgroundColor: ColorConstants.kPrimaryColor,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext bc) => [
              const PopupMenuItem(child: Text("Logout"), value: 0),
              // PopupMenuItem(
              //     child: Text("New Group Chat"), value: "/new-group-chat"),
              //PopupMenuItem(child: Text("Settings"), value: "/settings"),
            ],
            onSelected: (route) {
              if (route == 0) {
                logoutUser(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserType()),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Background(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: size.height * 0.10),
            color: Colors.white,
            child: ListView(
              controller: _scrollController,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                // gridView(),

                // Container(
                //   child: image1 != null
                //       ? Image.file(
                //           //File('img22'),
                //           image1!,
                //           fit: BoxFit.cover,
                //         )
                //       : Image.asset(
                //           "assets/images/placeholder.png",
                //           fit: BoxFit.cover,
                //         ),
                // ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Attach Three Images \n For ' + status!,
                      style: const TextStyle(
                        fontSize: 22,
                        color: ColorConstants.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 24.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  width: double.infinity,
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Image One',
                        style: TextStyle(
                          color: ColorConstants.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            height: size.height * 0.20,
                            width: size.width,
                            // margin: const EdgeInsets.only(left: 50, right: 50),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0.0,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 2.0),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenImage(image1, 'Image One')),
                                );
                              },
                              child: Container(
                                child: image1 != null
                                    ? Image.file(
                                        //File('img22'),
                                        image1!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/placeholder.png",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: InkWell(
                              onTap: () =>
                                  pickImage1(ImageSource.camera, context),
                              // takePhoto(ImageSource.camera);

                              child: CircleAvatar(
                                radius: size.height * 0.024,
                                backgroundColor: ColorConstants.kPrimaryColor,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 24.0),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  width: double.infinity,
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Image Two',
                        style: TextStyle(
                          color: ColorConstants.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            height: size.height * 0.20,
                            width: size.width,
                            // margin: const EdgeInsets.only(left: 50, right: 50),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0.0,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 2.0),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenImage(image2, 'Image Two')),
                                );
                              },
                              child: Container(
                                child: image2 != null
                                    ? Image.file(
                                        //File('img22'),
                                        image2!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/placeholder.png",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: InkWell(
                              onTap: () =>
                                  pickImage2(ImageSource.camera, context),
                              // takePhoto(ImageSource.camera);

                              child: CircleAvatar(
                                radius: size.height * 0.024,
                                backgroundColor: ColorConstants.kPrimaryColor,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 24.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  width: double.infinity,
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Image Three',
                        style: TextStyle(
                          color: ColorConstants.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            height: size.height * 0.20,
                            width: size.width,
                            // margin: const EdgeInsets.only(left: 50, right: 50),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0.0,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 2.0),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                          image3, 'Image Three')),
                                );
                              },
                              child: Container(
                                child: image3 != null
                                    ? Image.file(
                                        //File('img22'),
                                        image3!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/placeholder.png",
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: InkWell(
                              onTap: () =>
                                  pickImage3(ImageSource.camera, context),
                              // takePhoto(ImageSource.camera);

                              child: CircleAvatar(
                                radius: size.height * 0.024,
                                backgroundColor: ColorConstants.kPrimaryColor,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Container(
                //   padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                //   //child:Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(left: 12.0),
                //         child: Text(
                //           'Image Two',
                //           style: TextStyle(
                //             color: ColorConstants.kPrimaryColor,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () => pickImage2(ImageSource.camera, context),
                //         // takePhoto(
                //         // Source.camera);

                //         child: CircleAvatar(
                //           radius: size.height * 0.024,
                //           backgroundColor: ColorConstants.kPrimaryColor,
                //           child: Icon(
                //             Icons.camera_alt_rounded,
                //             color: Colors.white,
                //             size: 18,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //   //),
                //   //),
                // ),
                // Container(
                //   height: size.height * 0.20,
                //   width: size.height * 0.18,
                //   margin: const EdgeInsets.only(left: 50, right: 50),
                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     border: Border.all(
                //       color: Colors.white,
                //       width: 4.0,
                //     ),
                //     boxShadow: const [
                //       BoxShadow(
                //         color: Colors.black26,
                //         spreadRadius: 0.0,
                //         blurRadius: 6.0,
                //         offset: Offset(0.0, 2.0),
                //       ),
                //     ],
                //   ),
                //   child: GestureDetector(
                //     onTap: () async {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 FullScreenImage(image2, 'Image Two')),
                //       );
                //     },
                //     child: Container(
                //       child: image2 != null
                //           ? Image.file(
                //               image2!,
                //               fit: BoxFit.cover,
                //             )
                //           : Image.asset(
                //               "assets/images/placeholder.png",
                //               fit: BoxFit.cover,
                //             ),
                //     ),
                //   ),
                // ),
                // const Divider(height: 24.0),
                // Container(
                //   padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                //   //child:Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Padding(
                //         padding: EdgeInsets.only(left: 12.0),
                //         child: Text(
                //           'Image Three',
                //           style: TextStyle(
                //             color: ColorConstants.kPrimaryColor,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //         onTap: () => pickImage3(ImageSource.camera, context),
                //         // takePhoto(ImageSource.camera);

                //         child: CircleAvatar(
                //           radius: size.height * 0.024,
                //           backgroundColor: ColorConstants.kPrimaryColor,
                //           child: const Icon(
                //             Icons.camera_alt_rounded,
                //             color: Colors.white,
                //             size: 18,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //   //),
                // ),
                // Container(
                //   height: size.height * 0.20,
                //   width: size.height * 0.18,
                //   margin: const EdgeInsets.only(left: 50, right: 50),
                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     border: Border.all(
                //       color: Colors.white,
                //       width: 4.0,
                //     ),
                //     boxShadow: const [
                //       BoxShadow(
                //         color: Colors.black26,
                //         spreadRadius: 0.0,
                //         blurRadius: 6.0,
                //         offset: Offset(0.0, 2.0),
                //       ),
                //     ],
                //   ),
                //   child: GestureDetector(
                //     onTap: () async {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 FullScreenImage(image3, 'Image Three')),
                //       );
                //     },
                //     child: Container(
                //       child: image3 != null
                //           ? Image.file(
                //               image3!,
                //               fit: BoxFit.cover,
                //             )
                //           : Image.asset(
                //               "assets/images/placeholder.png",
                //               fit: BoxFit.cover,
                //             ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 16.0),
                  // height: 70,
                  //padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    // color: Colors.indigo,
                    gradient: LinearGradient(colors: [
                      ColorConstants.kPrimaryUltraLightColor,
                      ColorConstants.kPrimaryUltraLightColor
                    ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Longitude: $long",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.kPrimaryColor),
                      ),
                      Text(
                        "Latitude: $lat",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.kPrimaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.0,
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Image.asset('assets/images/image-2.jpeg'),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Text(
                          'Download GPS camera from the link provided and upload the photographs using GPS details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Container(
                    //padding: const EdgeInsets.all(10.0),
                    child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 16.0),
                  // color: ColorConstants.kPrimaryColor,
                  child: MaterialButton(
                    elevation: 2.0,
                    color: ColorConstants.kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    onPressed: () async {
                      //maxStatus=(maxStatus+1)!;
                      //status4=status4+1
                      //print('MXST '+maxStatus.toString());
                      // if(maxStatus==null)
                      //   {
                      //     maxStatus=0;
                      //     setState(() {
                      //       maxStatus=maxStatus+1;
                      //     });
                      //   }
                      // else
                      //   {
                      //     setState(() {
                      //       maxStatus=maxStatus+1;
                      //     });
                      //
                      //   }
                      print('VStatus : ' + maxStatus.toString());
                      //MySharedPreferences.instance.setIntegerValue("status", status4);
                      //String ref_ws=ref_no.substring(ref_no.lastIndexOf("/") + 1);
                      // int status1=int.parse(status);
                      // status1=status1+1;
                      //_updateStatus(ref_no,status);
                      // print('VStatus : '+status4.toString());

                      //_update(ref_no,khata_no,plot_no,imagePath,status.toString(),lat,long);
                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardPage()));
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     margin: const EdgeInsets.all(5),
                //     width: double.infinity,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       child: const Text('SAVE '),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
