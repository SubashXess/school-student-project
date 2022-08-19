import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final File? image;
  final String? tag;
  const FullScreenImage( this.image, this.tag) : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded,
            color: Colors.white,),
        ),
        title: Column(
          children: [
            Text(tag!,
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag!,
              child:Container(
                child: image != null
                    ? Image.file(
                  width: MediaQuery.of(context).size.width,
                  image!,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.cover,
                ),
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