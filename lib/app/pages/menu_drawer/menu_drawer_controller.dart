import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/menu_drawer/menu_drawer_presenter.dart';
import 'package:tw_app/data/repositories/local/data_local_authentication_repository.dart';
import 'package:tw_app/domain/entities/auth/me.dart';
import 'package:tw_app/domain/usecases/authentication/logout_authentication_usecase.dart';

class MenuDrawerController extends Controller {
  MenuDrawerController(Me? userData,
      DataLocalAuthenticationRepository dataLocalAuthenticationRepository)
      : user = userData,
        presenter = MenuDrawerPresenter(dataLocalAuthenticationRepository);

  final MenuDrawerPresenter presenter;
  Me? user;

  @override
  void initListeners() {
    presenter.logoutOnComplete = () {};
    presenter.logoutOnError = (e) {};
    presenter.logoutOnNext = logoutComplete;
  }

  void logout(BuildContext context) {
    presenter.logout(context);
  }

  void logoutComplete(LogoutAuthenticationUseCaseResponse? response) async {
    if (response != null) {
      Map<String, dynamic> args = <String, dynamic>{};
      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushNamedAndRemoveUntil(
        getContext(),
        Pages.loginPage,
        (route) => false,
        arguments: args,
      );
    }
  }
}
