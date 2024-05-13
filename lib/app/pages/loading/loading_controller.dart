import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/loading/loading_presenter.dart';
import 'package:tw_app/data/repositories/local/data_local_authentication_repository.dart';
import 'package:tw_app/data/repositories/remote/data_remote_authentication_repository.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

class LoadingController extends Controller {
  LoadingController(
      DataLocalAuthenticationRepository dataLocalAuthenticationRepository,
      DataRemoteAuthenticationRepository dataRemoteAuthenticationRepository)
      : presenter = LoadingPresenter(dataLocalAuthenticationRepository,
            dataRemoteAuthenticationRepository),
        super();

  final LoadingPresenter presenter;

  @override
  void onInitState() {
    super.onInitState();
    presenter.checkAuth();
  }

  @override
  void initListeners() {
    presenter.checkAuthOnComplete = () {};
    presenter.checkAuthOnError = (error) {};
    presenter.checkAuthOnNext = veifyStatus;

    presenter.getMeOnComplete = () {};
    presenter.getMeOnError = (error) {};
    presenter.getMeOnNext = userReady;
  }

  Future<void> veifyStatus(String? response) async {
    if (response != null) {
      presenter.getMe();
    } else {
      goLoginScreen();
    }
  }

  void userReady(Me? response) {
    if (response != null) {
      Map<String, dynamic> args = <String, dynamic>{};
      args['user'] = response;

      Navigator.pushNamedAndRemoveUntil(
        getContext(),
        Pages.homePage,
        (route) => false,
        arguments: args,
      );
    } else {
      goLoginScreen();
    }
  }

  void goLoginScreen() async {
    // await Future.delayed(const Duration(seconds: 5));
    Map args = <String, dynamic>{};
    Navigator.pushNamedAndRemoveUntil(
      getContext(),
      Pages.loginPage,
      (r) => false,
      arguments: args,
    );
  }
}
