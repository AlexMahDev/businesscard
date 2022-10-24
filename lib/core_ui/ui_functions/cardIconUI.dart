import 'package:flutter/material.dart';

class IconUI {
  Widget getIcon(String key) {
    if (key == 'phoneNumber') {
      return const Icon(Icons.phone, color: Colors.white);
    } else if (key == 'email') {
      return const Icon(Icons.email, color: Colors.white);
    } else if (key == 'link') {
      return const Icon(Icons.link, color: Colors.white);
    } else if (key == 'linkedIn') {
      return Image.asset('assets/images/icons/linkedin-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'gitHub') {
      return Image.asset('assets/images/icons/github-icon.png',
          color: Colors.white, height: 20);
    } else if (key == 'telegram') {
      return const Icon(Icons.telegram, color: Colors.white);
    } else {
      return const Icon(Icons.add_circle_outline_rounded, color: Colors.white);
    }
  }
}
