import 'package:flutter/material.dart';
import 'package:pmajg/Constants/ColorConstants.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2.0),
        backgroundColor: MaterialStateProperty.all(ColorConstants.kPrimaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0)),
      ),
      child: Text('See Details'),
    );
  }
}
