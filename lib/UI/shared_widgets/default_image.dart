import 'package:flutter/material.dart';

class DefaultImage extends StatelessWidget {
  final size;

  DefaultImage({required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(
        'assets/images/default_profile.jpg',
        fit: BoxFit.cover,
        width: size,
        height: size,
      ),
    );
  }
}
