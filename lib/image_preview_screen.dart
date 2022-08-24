// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pmajg/Constants/ColorConstants.dart';
import 'package:pmajg/fullscreen_preview_image.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({Key? key, required this.appbartitle})
      : super(key: key);

  final String appbartitle;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.kPrimaryColor,
        centerTitle: true,
        title: Text(widget.appbartitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Image Preview',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              SizedBox(
                height: size.height / 4,
                width: size.width / 1.5,
                child: InkWell(
                  onTap: () {
                    print('img1');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FullScreenImagePreview(
                          image: 'assets/images/demo-img.jpg',
                          tag: 'imageHero1',
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'imageHero1',
                    child: Card(
                      color: ColorConstants.kPrimaryLightColor2,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        'assets/images/demo-img.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              RatingBar.builder(
                itemSize: 20,
                initialRating: 0,
                minRating: 0,
                allowHalfRating: false,
                itemCount: 5,
                glowColor: ColorConstants.kPrimaryColor,
                unratedColor: ColorConstants.kPrimaryLightColor2,
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: ColorConstants.kPrimaryColor,
                  );
                },
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                height: size.height / 4,
                width: size.width / 1.5,
                child: InkWell(
                  onTap: () {
                    print('img2');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FullScreenImagePreview(
                          image: 'assets/images/demo-img-2.jpg',
                          tag: 'imageHero2',
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'imageHero2',
                    child: Card(
                      color: ColorConstants.kPrimaryLightColor2,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        'assets/images/demo-img-2.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              RatingBar.builder(
                itemSize: 20,
                initialRating: 0,
                minRating: 0,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: ColorConstants.kPrimaryColor,
                  );
                },
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                height: size.height / 4,
                width: size.width / 1.5,
                child: InkWell(
                  onTap: () {
                    print('img3');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FullScreenImagePreview(
                          image: 'assets/images/demo-img-3.jpg',
                          tag: 'imageHero3',
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'imageHero3',
                    child: Card(
                      color: ColorConstants.kPrimaryLightColor2,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        'assets/images/demo-img-3.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              RatingBar.builder(
                itemSize: 20,
                initialRating: 0,
                minRating: 0,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: ColorConstants.kPrimaryColor,
                  );
                },
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              // SizedBox(
              //   width: size.width / 1.5,
              //   child: ListView.builder(
              //     clipBehavior: Clip.none,
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     // itemExtent: 200.0,
              //     physics: const NeverScrollableScrollPhysics(),
              //     padding: EdgeInsets.zero,
              //     itemBuilder: (context, index) {
              //       return SizedBox(
              //         height: size.height / 4,
              //         child: InkWell(
              //           onTap: () {
              //             print(imageItems[index]);
              //           },
              //           child: Card(
              //             color: ColorConstants.kPrimaryLightColor2,
              //             margin: const EdgeInsets.only(bottom: 10.0),
              //             child: Image.asset(
              //               imageItems[index].toString(),
              //               fit: BoxFit.contain,
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final List<String> imageItems = [
    'assets/images/demo-img.jpg',
    'assets/images/demo-img-2.jpg',
    'assets/images/demo-img-3.jpg',
  ];
}
