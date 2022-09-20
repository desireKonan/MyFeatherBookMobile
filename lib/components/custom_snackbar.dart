import 'package:flutter/material.dart';

class CustomSnackbar {
  final String text;

  const CustomSnackbar({required this.text});

  SnackBar _render() {
    return SnackBar(
      backgroundColor: Colors.teal,
      content: Container(
        margin: const EdgeInsets.all(5.5),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      duration: const Duration(milliseconds: 1500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.2),
        ),
      ),
    );
  }

  renderSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_render());
  }
}
