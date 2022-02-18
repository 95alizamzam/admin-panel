import 'package:flutter/material.dart';

class DefaultImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/default_user_image.png',
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    );
  }
}
