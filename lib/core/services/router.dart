import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/src/on_boarding/presentation/on_boarding_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case OnBoardingScreen.routeName:
    //   return _pageBuilder((_) => const OnBoardingScreen(), settings);

    default:
      return _pageBuilder((_) => const PageUnderConstruction(), settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page,
  RouteSettings settings,
) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    pageBuilder: (context, _, __) => page(context),
  );
}
