import 'package:flutter/material.dart';

class RTextFieldswidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool? readOnly;
  final String labelText;
  final VoidCallback? onTap;

  const RTextFieldswidget({
    Key? key,
    required this.controller,
    required this.validator,
    required this.labelText,
    this.onTap,
    this.readOnly
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly?? false,
        controller: controller,
        obscureText: false,
        cursorColor: const Color.fromRGBO(220, 150, 89, 1.0),
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}