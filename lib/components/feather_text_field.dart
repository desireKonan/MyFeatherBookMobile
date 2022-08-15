import 'package:flutter/material.dart';

class FeatherTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String labelText;

  final int? maxLine;

  //final Function? tapped;

  const FeatherTextField(
      {Key? key, this.controller, required this.labelText, this.maxLine
      /*this.tapped*/
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 61, 144, 212),
          hintText: labelText,
          hintStyle: const TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 166, 172, 177),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 61, 144, 212),
              width: 5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
        ),
        maxLines: maxLine,
      ),
    );
  }
}
