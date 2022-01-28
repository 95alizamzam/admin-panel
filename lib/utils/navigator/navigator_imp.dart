import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/home_screen/home_screen.dart';
import 'package:marketing_admin_panel/UI/splach_screen/splach_screen.dart';
import 'package:marketing_admin_panel/utils/navigator/named_navigator.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:page_transition/page_transition.dart';

class navigatorImp implements NamedNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NamedRoutes.SPLASH_SCREEN:
        return PageTransition(
          child: SplachScreen(
            navigator: navigatorState,
          ),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
        );

      case NamedRoutes.HOME_SCREEN:
        return PageTransition(
          child: HomeScreen(
            navigator: navigatorState,
          ),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => SplachScreen(
            navigator: navigatorState,
          ),
        );
    }
  }

  @override
  Future push(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
  }) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    }

    if (replace) {
      return navigatorState.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    }

    return navigatorState.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }
}
