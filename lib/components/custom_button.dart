import 'package:flutter/material.dart';
import 'package:property_in_homs/utils/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.myButtonText,
    this.myTextColor,
    this.backgroundColor,
    this.borderColor,
    required this.onPressed,
    this.myImageName,
  });

  final String myButtonText;
  final String? myImageName;
  final Color? borderColor;
  final Color? myTextColor;
  final Color? backgroundColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) onPressed!();
      },
      style: ElevatedButton.styleFrom(
        side: borderColor != null
            ? BorderSide(
                width: 1.0,
                color: borderColor!,
              )
            : null,
        backgroundColor: backgroundColor ?? AppColors.mainNavyColor,
        shape: const StadiumBorder(),
        fixedSize: Size(
          size.width * 0.9,
          size.height * 0.08,
        ),
      ),
      child: Text(
        myButtonText,
        style: TextStyle(
          color: myTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
