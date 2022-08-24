import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;
  const SplashBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Image.asset(
            'assets/images/top-logo.jpeg',
            width: size.width * 0.75,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/image-3.jpeg',
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/image-1.jpeg',
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/image-5.jpeg',
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/image-4.jpeg',
              width: size.width * 0.35,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
