import 'package:flutter/material.dart';
import 'package:pmajg/constants/ColorConstants.dart';

class PhaseButtonWidget extends StatelessWidget {
  const PhaseButtonWidget({
    Key? key,
    required this.size,
    required this.label,
    required this.viewbtn, required this.onPressed, required this.onPressedView,
  }) : super(key: key);

  final Size size;
  final String label;
  final String viewbtn;
  final VoidCallback onPressed;
  final VoidCallback onPressedView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MaterialButton(
            color: ColorConstants.kPrimaryColor,
            textColor: Colors.white,
            height: size.height * 0.08,
            minWidth: size.width * 0.4,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                onPressed: onPressedView,
                child: Text(
                  viewbtn,
                  style: const TextStyle(color: ColorConstants.kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
