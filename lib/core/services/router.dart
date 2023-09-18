import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings,
      );

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
