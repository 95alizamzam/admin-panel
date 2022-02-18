import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:marketing_admin_panel/utils/shared_widgets.dart';

class SplachScreen extends StatefulWidget {
  final navigator;
  const SplachScreen({Key? key, this.navigator}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  bool isLoading = true;
  void timer() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
    });
  }

  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Marketing App ',
                style: Constants.TEXT_STYLE8,
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome Admin Of The App',
                style: Constants.TEXT_STYLE1,
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const CircularProgressIndicator(
                      color: MyColors.lightBlue,
                    )
                  : SharedWidgets.customButton(
                      width: 200,
                      ontap: () {
                        navigatorImp().push(
                          NamedRoutes.HOME_SCREEN,
                          clean: true,
                        );
                      },
                      buttonLabel: 'Get Started',
                      padding: 14,
                      radius: 15,
                      labelColor: MyColors.primaryColor,
                      labelSize: 20,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
