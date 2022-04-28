import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/bloc/admin_bloc/admin_bloc.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/bills_bloc.dart';
import 'package:marketing_admin_panel/bloc/currencies_bloc/currencies_bloc.dart';
import 'package:marketing_admin_panel/bloc/most_users_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_bloc.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'bloc/category_bloc/change_bloc.dart';
import 'bloc/users_bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  //set status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: MyColors.secondaryColor,
      // //systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
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
        BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<MostUsersBloc>(create: (context) => MostUsersBloc()),
        BlocProvider<OfferBloc>(create: (context) => OfferBloc()),
        BlocProvider<AdminBloc>(create: (context) => AdminBloc()),
        BlocProvider<CurrenciesBloc>(create: (context) => CurrenciesBloc()),
        BlocProvider<BillsBloc>(create: (context) => BillsBloc()),
        BlocProvider<PointsBloc>(create: (context) => PointsBloc()),
      ],
      child: MaterialApp(
        title: 'Marketing Admin Panel',
        builder: EasyLoading.init(),
        theme: ThemeData(
          primaryColor: MyColors.primaryColor,
          scaffoldBackgroundColor: MyColors.primaryColor,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: MyColors.primaryColor,
            actionsIconTheme: IconThemeData(
              color: MyColors.secondaryColor,
            ),
            titleTextStyle: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: MyColors.secondaryColor,
                letterSpacing: 0.5),
            iconTheme: IconThemeData(
              color: MyColors.secondaryColor,
            ),
          ),
        ),
        initialRoute: NamedRoutes.SPLASH_SCREEN,
        onGenerateRoute: NavigatorImpl.onGenerateRoute,
        navigatorKey: NavigatorImpl.navigatorState,
      ),
    );
  }
}
