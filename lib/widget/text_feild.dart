import 'package:flutter/material.dart';

Widget textFromFeild({
  required TextEditingController controller,
  required String hint,
  Function(String)? onChanged,
  String? Function(String?)? validator,
  TextInputType inputType = TextInputType.text,
  int? maxLen,
  int maxLine = 1,
  bool texthide = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular(8),
  ),
    child: TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: texthide,
      maxLines: maxLine,
      maxLength: maxLen,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        counterText: "",
        border: InputBorder.none,
        labelText: hint,
      ),
    ),
  );
}
