import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroler;
  final String? Function(String?)? validator;
  CustomField(
      {super.key,
      required this.hint,
      required this.mycontroler,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: mycontroler,
        decoration: InputDecoration(
          hintText: hint,
          //contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
          fillColor: Colors.grey[200],
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          filled: true,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(45)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(45)),
        ));
  }
}
