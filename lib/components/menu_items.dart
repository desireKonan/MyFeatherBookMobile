import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/helpers/constants.dart';

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final double size;
  final String title;

  const DrawerMenuItem(
      {Key? key, required this.icon, required this.size, required this.title})
      : super(key: key);

  _clickOnMenuItem() {
    print("Affichez l'élément selectionné !");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: _clickOnMenuItem,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Icon(this.icon, size: this.size, color: Colors.black),
              ),
              Expanded(flex: 3, child: Text(this.title, style: textStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
