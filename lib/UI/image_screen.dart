import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class ImageScreen extends StatelessWidget {
  final navigator;
  final imageUrl;
  final heroTag;

  ImageScreen({required this.heroTag, required this.imageUrl, this.navigator});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: (){
                NavigatorImpl().pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Hero(
            tag: heroTag,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
