import 'package:flutter/material.dart';

class FullScreenImagePreview extends StatelessWidget {
  final String image;
  final Object tag;
  const FullScreenImagePreview(
      {Key? key, required this.image, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            // tag: 'imageHero',
            tag: tag,
            child: Image.asset(
              image.toString(),
              fit: BoxFit.contain,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
