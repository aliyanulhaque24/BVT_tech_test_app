import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;
  final TextInputType? keyboardType;
  const InputField({
    super.key,
    required this.controller,
    required this.textInputAction,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    bool isNumericKeyboard = keyboardType == TextInputType.number;
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      style: TextStyle(fontSize: 20.sp, color: Color.fromARGB(255, 71, 71, 71)),
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters: isNumericKeyboard
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
        fillColor: Color.fromARGB(255, 220, 220, 220),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 3, 196, 103),
            width: 2.w,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 20.sp, color: Colors.grey[600]),
      ),
    );
  }
}
