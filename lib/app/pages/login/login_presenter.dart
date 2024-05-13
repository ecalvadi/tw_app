import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/domain/entities/auth/login.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';
import 'package:tw_app/domain/usecases/authentication/get_me_authentication_usecase.dart';
import 'package:tw_app/domain/usecases/authentication/login_authentication_usecase.dart';

class LoginPresenter extends Presenter {
  Function? loginOnNext;
  Function? loginOnError;
  Function? loginOnComplete;
  Function? getMeOnNext;
  Function? getMeOnError;
  Function? getMeOnComplete;

  LoginAuthenticationUseCase _loginAuthenticationUseCase;
  GetMeAuthenticationUseCase _getMeAuthenticationUseCase;

  LoginPresenter(AuthenticationRepository authenticationRepository)
      : _loginAuthenticationUseCase =
            LoginAuthenticationUseCase(authenticationRepository),
        _getMeAuthenticationUseCase =
            GetMeAuthenticationUseCase(authenticationRepository);

  @override
  void dispose() {
    _loginAuthenticationUseCase.dispose();
    _getMeAuthenticationUseCase.dispose();
  }

  void login(Login login) {
    _loginAuthenticationUseCase.execute(
        _LoginAuthenticationUseCaseObserver(this),
        LoginAuthenticationUseCaseParams(login));
  }

  void getMe() {
    _getMeAuthenticationUseCase
        .execute(_GetMeAuthenticationUseCaseObserver(this));
  }
}

class _LoginAuthenticationUseCaseObserver
    implements Observer<LoginAuthenticationUseCaseResponse> {
  final LoginPresenter presenter;
  _LoginAuthenticationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.loginOnComplete != null);
    presenter.loginOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.loginOnComplete != null);
    presenter.loginOnError!(e);
  }

  @override
  void onNext(LoginAuthenticationUseCaseResponse? response) {
    assert(presenter.loginOnComplete != null);
    presenter.loginOnNext!(response);
  }
}

class _GetMeAuthenticationUseCaseObserver
    implements Observer<GetMeAuthenticationUseCaseResponse> {
  final LoginPresenter presenter;
  _GetMeAuthenticationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getMeOnComplete != null);
    presenter.getMeOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.getMeOnError != null);
    presenter.getMeOnError!(e);
  }

  @override
  void onNext(GetMeAuthenticationUseCaseResponse? response) {
    assert(presenter.getMeOnNext != null);
    presenter.getMeOnNext!(response!);
  }
}
