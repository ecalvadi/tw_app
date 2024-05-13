import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/login/login_presenter.dart';
import 'package:tw_app/app/widgets/confirm.dart';
import 'package:tw_app/data/repositories/remote/data_remote_authentication_repository.dart';
import 'package:tw_app/domain/entities/auth/login.dart';
import 'package:tw_app/domain/usecases/authentication/get_me_authentication_usecase.dart';

import 'package:tw_app/domain/usecases/authentication/login_authentication_usecase.dart';

class LoginController extends Controller {
  LoginController(
      DataRemoteAuthenticationRepository dataRemoteAuthenticationRepository)
      : presenter = LoginPresenter(dataRemoteAuthenticationRepository);

  final LoginPresenter presenter;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool hidePassword = true;

  @override
  void initListeners() {
    presenter.loginOnComplete = () {};
    presenter.loginOnError = (e) {
      getDialogConfirm(getContext(), 'Error',
          'Usuario o contraseña incorrectos... vuelva a intentar.');
    };
    presenter.loginOnNext = loginOnNext;
    presenter.getMeOnComplete = () {};
    presenter.getMeOnError = (e) {};
    presenter.getMeOnNext = getMeOnNext;
  }

  void loginOnNext(LoginAuthenticationUseCaseResponse? response) {
    if (response != null) {
      if (response.token!.accessToken != null) {
        presenter.getMe();
      }
    }
  }

  void getMeOnNext(GetMeAuthenticationUseCaseResponse? response) {
    if (response != null) {
      Map<String, dynamic> args = <String, dynamic>{};
      print(response.me!.toJson());
      args['user'] = response.me;

      Navigator.pushNamedAndRemoveUntil(
        getContext(),
        Pages.homePage,
        (route) => false,
        arguments: args,
      );
    }
  }

  void showPassword() {
    hidePassword = !hidePassword;
    refreshUI();
  }

  void login() {
    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
      Login login = Login(email: email.text, password: pass.text);
      presenter.login(login);
    }
  }
}
