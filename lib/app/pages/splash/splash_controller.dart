import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/splash/splash_presenter.dart';

class SplashController extends Controller {
  SplashController() : presenter = SplashPresenter();

  final SplashPresenter presenter;

  @override
  void onInitState() {
    // TODO: implement onInitState
    super.onInitState();
    goLoadingScreen();
  }

  @override
  void initListeners() {}

  void goLoadingScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    Map args = <String, dynamic>{};
    Navigator.pushNamedAndRemoveUntil(
      getContext(),
      Pages.loadingPage,
      (r) => false,
      arguments: args,
    );
  }
}
