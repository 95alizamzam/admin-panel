import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/left_part.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/middle_part.dart';

class HomeScreen extends StatelessWidget {
  final navigator;
  const HomeScreen({Key? key, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            LeftPart(),
            MiddlePart(),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     color: Colors.blue,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
