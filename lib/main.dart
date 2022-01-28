import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/bloc.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PanelBloc(),
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
