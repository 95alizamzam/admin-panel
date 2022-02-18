import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';

import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

import 'bloc/category_bloc/change_bloc.dart';
import 'bloc/changeLeftPart/bloc.dart';
import 'bloc/userbloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PanelBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => OfferBloc()),
      ],
      child: MaterialApp(
        title: 'Marketing Admin Panel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: NamedRoutes.SPLASH_SCREEN,
        onGenerateRoute: navigatorImp.onGenerateRoute,
        navigatorKey: navigatorImp.navigatorState,
      ),
    );
  }
}
