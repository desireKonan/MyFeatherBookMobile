import 'package:flutter/material.dart';

class CustomSnackbar {
  final String text;

  const CustomSnackbar({required this.text});

  SnackBar _render() {
    return SnackBar(
      backgroundColor: Colors.blue,
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(microseconds: 5000),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
    );
  }

  renderSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_render());
  }
}
