import 'package:flutter/material.dart';
import 'package:my_feather_book_mobile/components/custom_drawer_header.dart';
import 'package:my_feather_book_mobile/components/menu_items.dart';

//Toutes les fonctions concernant l'interface graphique de notre application.
Widget buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    width: 300,
    child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const CustomDrawerHeader(),
            myDrawerList(),
          ],
        ),
      ),
    ),
  );
}

Widget myDrawerList() {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      children: const [
        DrawerMenuItem(icon: Icons.home, size: 20, title: 'Home'),
        DrawerMenuItem(icon: Icons.settings, size: 20, title: 'Paramètres'),
        DrawerMenuItem(icon: Icons.info, size: 20, title: 'A propos'),
      ],
    ),
  );
}
