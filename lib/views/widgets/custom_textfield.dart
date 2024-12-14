import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final Icon? suffixIcon;
  final VoidCallback? onPressedSuffix;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  const CustomTextfield({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    this.onPressedSuffix,
    required this.obscureText, required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: textInputType,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onPressedSuffix, icon: suffixIcon!)
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
          filled: true,
          fillColor: Colors.black12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: Colors.blue.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}