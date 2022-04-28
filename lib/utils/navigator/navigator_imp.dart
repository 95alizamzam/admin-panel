import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/home_screen/home_screen.dart';
import 'package:marketing_admin_panel/UI/login_screen/login_screen.dart';
import 'package:marketing_admin_panel/UI/offers_tab/image_details_screen.dart';
import 'package:marketing_admin_panel/UI/offers_tab/post_details_screen.dart';
import 'package:marketing_admin_panel/UI/offers_tab/product_details_screen.dart';
import 'package:marketing_admin_panel/UI/offers_tab/video_details_screen.dart';
import 'package:marketing_admin_panel/UI/splach_screen/splach_screen.dart';
import '../../UI/image_screen.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/user_details_screen.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/utils/navigator/named_navigator.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorImpl implements NamedNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NamedRoutes.SPLASH_SCREEN:
        return PageTransition(
          child: SplashScreen(
            navigator: navigatorState,
          ),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
        );

      case NamedRoutes.LOGIN_SCREEN:
        return PageTransition(
          child: LoginScreen(
            navigator: navigatorState,
          ),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
        );

      case NamedRoutes.IMAGE_SCREEN:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => ImageScreen(
              navigator: navigatorState,
              heroTag: data['heroTag'],
              imageUrl: data['imageUrl'],
            ),
          );
        }

      case NamedRoutes.HOME_SCREEN:
        return PageTransition(
          child: HomeScreen(
            navigator: navigatorState,
          ),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
        );

      case NamedRoutes.UserDetails:
        {
          final data = settings.arguments as Map<String, dynamic>;

          return PageTransition(
            child: UserDetails(
              navigator: navigatorState,
              user: data['user'],
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500),
          );
        }

      case NamedRoutes.PRODUCT_DETAILS_SCREEN:
        {
          final data = settings.arguments as Map<String, dynamic>;

          return PageTransition(
            child: ProductDetailsScreen(
              navigator: navigatorState,
              product: data['product'],
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500),
          );
        }

      case NamedRoutes.IMAGE_DETAILS_SCREEN:
        {
          final data = settings.arguments as Map<String, dynamic>;

          return PageTransition(
            child: ImageDetailsScreen(
              navigator: navigatorState,
              offer: data['offer'],
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500),
          );
        }

      case NamedRoutes.POST_DETAILS_SCREEN:
        {
          final data = settings.arguments as Map<String, dynamic>;

          return PageTransition(
            child: PostDetailsScreen(
              navigator: navigatorState,
              post: data['post'],
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500),
          );
        }

      case NamedRoutes.VIDEO_DETAILS_SCREEN:
        {
          final data = settings.arguments as Map<String, dynamic>;

          return PageTransition(
            child: VideoDetailsScreen(
              navigator: navigatorState,
              video: data['video'],
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500),
          );
        }

      default:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(
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
