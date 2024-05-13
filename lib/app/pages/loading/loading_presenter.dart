import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/repositories/authentication_repository.dart';
import 'package:tw_app/domain/usecases/authentication/check_auth_authentication_usecase.dart';
import 'package:tw_app/domain/usecases/authentication/get_me_authentication_usecase.dart';

class LoadingPresenter extends Presenter {
  Function? getMeOnComplete;
  Function? getMeOnError;
  Function? getMeOnNext;

  Function? checkAuthOnComplete;
  Function? checkAuthOnError;
  Function? checkAuthOnNext;

  CheckAuthAuthenticationUseCase _checkAuthAuthenticationUseCase;
  GetMeAuthenticationUseCase _getMeAuthenticationUseCase;

  LoadingPresenter(
      AuthenticationRepository local, AuthenticationRepository remote)
      : _checkAuthAuthenticationUseCase = CheckAuthAuthenticationUseCase(local),
        _getMeAuthenticationUseCase = GetMeAuthenticationUseCase(remote);

  @override
  void dispose() {
    _checkAuthAuthenticationUseCase.dispose();
    _getMeAuthenticationUseCase.dispose();
  }

  void checkAuth() {
    _checkAuthAuthenticationUseCase
        .execute(_CheckAuthAuthenticationUseCaseObserver(this));
  }

  void getMe() {
    _getMeAuthenticationUseCase
        .execute(_GetMeAuthenticationUseCaseObserver(this));
  }
}

class _CheckAuthAuthenticationUseCaseObserver
    implements Observer<CheckAuthAuthenticationUseCaseResponse> {
  final LoadingPresenter presenter;
  _CheckAuthAuthenticationUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.checkAuthOnComplete != null);
    presenter.checkAuthOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.checkAuthOnError != null);
    presenter.checkAuthOnError!(e);
  }

  @override
  void onNext(CheckAuthAuthenticationUseCaseResponse? response) {
    assert(presenter.checkAuthOnNext != null);
    presenter.checkAuthOnNext!(response!.token);
  }
}

class _GetMeAuthenticationUseCaseObserver
    implements Observer<GetMeAuthenticationUseCaseResponse> {
  final LoadingPresenter presenter;
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
    presenter.getMeOnNext!(response!.me);
  }
}
