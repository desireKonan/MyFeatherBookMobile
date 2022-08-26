import 'package:flutter/material.dart';

class OutlineTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String labelText;

  final int? maxLine;

  const OutlineTextField({
    Key? key,
    this.controller,
    required this.labelText,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          backgroundColor: Colors.white30,
          color: Colors.teal,
        ),
        decoration: InputDecoration(
          fillColor: Colors.teal,
          hintText: labelText,
          hintStyle: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 166, 172, 177),
          ),
          border: InputBorder.none,
          focusColor: Colors.teal,
        ),
        maxLines: maxLine,
      ),
    );
  }
}
