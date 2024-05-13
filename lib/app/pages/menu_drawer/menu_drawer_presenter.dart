import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';
import 'package:tw_app/domain/usecases/authentication/logout_authentication_usecase.dart';

class MenuDrawerPresenter extends Presenter {
  Function? logoutOnComplete;
  Function? logoutOnError;
  Function? logoutOnNext;

  LogoutAuthenticationUseCase _logoutAuthenticationUseCase;

  MenuDrawerPresenter(AuthenticationRepository authenticationRepository)
      : _logoutAuthenticationUseCase =
            LogoutAuthenticationUseCase(authenticationRepository);

  @override
  void dispose() {
    _logoutAuthenticationUseCase.dispose();
  }

  void logout(BuildContext context) {
    _logoutAuthenticationUseCase.execute(
        _LogoutAuthenticationUseCaseObserver(this),
        LogoutAuthenticationUseCaseParams(context));
  }
}

class _LogoutAuthenticationUseCaseObserver
    implements Observer<LogoutAuthenticationUseCaseResponse> {
  final MenuDrawerPresenter presenter;
  _LogoutAuthenticationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.logoutOnComplete != null);
    presenter.logoutOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.logoutOnError != null);
    presenter.logoutOnError!(e);
  }

  @override
  void onNext(LogoutAuthenticationUseCaseResponse? response) {
    assert(presenter.logoutOnNext != null);
    presenter.logoutOnNext!(response);
  }
}
