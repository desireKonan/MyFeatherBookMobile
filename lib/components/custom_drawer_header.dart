import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile-image.jpg'),
              ),
            ),
          ),
          const Text(
            'MyFeatherBook',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const Text(
            'MyFeatherBook@gmail.com',
            style: TextStyle(
                color: Color.fromARGB(255, 211, 203, 203), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
