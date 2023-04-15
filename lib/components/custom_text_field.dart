import 'package:flutter/material.dart';
import 'package:property_in_homs/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.myLabelText,
    this.myHintText,
    required this.controller,
    required this.fillColor,
    this.hintTextColor,
    this.keyboardType,
    this.obscureText = false,
    this.myValidator,
    this.readOnly = false,
  });

  final String myLabelText;
  final String? myHintText;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? hintTextColor;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? myValidator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      // onChanged: myValidator,
      controller: controller,
      validator: myValidator,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        label: Text(myLabelText),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        constraints: BoxConstraints(
          maxHeight: size.height * 0.08,
          maxWidth: size.width * 0.9,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.transparentColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        hintStyle: hintTextColor != null
            ? TextStyle(
                color: hintTextColor,
              )
            : null,
        hintText: myHintText ?? "",
        fillColor: fillColor,
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      readOnly: readOnly,
    );
  }
}
