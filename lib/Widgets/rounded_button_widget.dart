import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final Color bgColor;
  final Color labelColor;
  final double borderRadius;
  final double fontSize;
  const RoundedButtonWidget({
    Key? key,
     required this.onPressed,
     required this.label,
     required this.bgColor,
     required this.labelColor,
    this.borderRadius = 12.0,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.065,
      child: MaterialButton(
        onPressed: onPressed,
        color: bgColor,
        textColor: labelColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        // padding: EdgeInsets.symmetric(
        //     vertical: verticalPadding!, horizontal: horizontalPadding!),
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
