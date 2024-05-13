import 'package:flutter/material.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/home/home_view.dart';

import 'package:tw_app/app/pages/loading/loading_view.dart';
import 'package:tw_app/app/pages/login/login_view.dart';
import 'package:tw_app/app/pages/splash/splash_view.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

class RouterApp {
  final RouteObserver<PageRoute> routeObserver;

  RouterApp() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    final Map args = settings.arguments as Map;

    // Pantallas públicas
    switch (settings.name) {
      case Pages.splashPage:
        return _buildRoute(settings, SplashPage());
      case Pages.loadingPage:
        return _buildRoute(settings, LoadingPage());
      case Pages.loginPage:
        return _buildRoute(settings, LoginPage());
    }

    final Me? user = args['user'] as Me?;

    if (user != null) {
      // pantallas privadas
      switch (settings.name) {
        case Pages.homePage:
          return _buildRoute(settings, HomePage(user: user));
      }
    }

    // Login
    return _buildRoute(settings, LoginPage());
  }

  MaterialPageRoute<dynamic> _buildRoute(
      RouteSettings settings, Widget builder) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (BuildContext ctx) => builder,
    );
  }
}
