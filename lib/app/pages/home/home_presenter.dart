import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/domain/entities/position.dart';
import 'package:tw_app/domain/repositories/position_repository.dart';
import 'package:tw_app/domain/usecases/position/create_position_usecase.dart';
import 'package:tw_app/domain/usecases/position/get_me_position_usecase.dart';
import 'package:tw_app/domain/usecases/position/update_position_usecase.dart';

class HomePresenter extends Presenter {
  Function? createPositionOnNext;
  Function? createPositionOnError;
  Function? createPositionOnComplete;

  Function? updatePositionOnNext;
  Function? updatePositionOnError;
  Function? updatePositionOnComplete;

  Function? getMePositionOnNext;
  Function? getMePositionOnError;
  Function? getMePositionOnComplete;

  CreatePositionUseCase _createPositionUseCase;
  UpdatePositionUseCase _updatePositionUseCase;
  GetMePositionUseCase _getMePositionUseCase;

  HomePresenter(PositionRepository positionRepository)
      : _createPositionUseCase = CreatePositionUseCase(positionRepository),
        _updatePositionUseCase = UpdatePositionUseCase(positionRepository),
        _getMePositionUseCase = GetMePositionUseCase(positionRepository);

  @override
  void dispose() {
    _createPositionUseCase.dispose();
    _updatePositionUseCase.dispose();
    _getMePositionUseCase.dispose();
  }

  void createPosition(Position position) {
    _createPositionUseCase.execute(_CreatePositionUseCaseObserver(this),
        CreatePositionUseCaseParams(position));
  }

  void updatePosition(Position position) {
    _updatePositionUseCase.execute(_UpdatePositionUseCaseObserver(this),
        UpdatePositionUseCaseParams(position));
  }

  void getMePosition() {
    _getMePositionUseCase.execute(_GetMePositionUseCaseObserver(this));
  }
}

class _CreatePositionUseCaseObserver
    implements Observer<CreatePositionUseCaseResponse> {
  final HomePresenter presenter;
  _CreatePositionUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.createPositionOnComplete != null);
    presenter.createPositionOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.createPositionOnComplete != null);
    presenter.createPositionOnError!(e);
  }

  @override
  void onNext(CreatePositionUseCaseResponse? response) {
    assert(presenter.createPositionOnComplete != null);
    presenter.createPositionOnNext!(response);
  }
}

class _UpdatePositionUseCaseObserver
    implements Observer<UpdatePositionUseCaseResponse> {
  final HomePresenter presenter;
  _UpdatePositionUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.updatePositionOnComplete != null);
    presenter.updatePositionOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.updatePositionOnComplete != null);
    presenter.updatePositionOnError!(e);
  }

  @override
  void onNext(UpdatePositionUseCaseResponse? response) {
    assert(presenter.updatePositionOnComplete != null);
    presenter.updatePositionOnNext!(response);
  }
}

class _GetMePositionUseCaseObserver
    implements Observer<GetMePositionUseCaseResponse> {
  final HomePresenter presenter;
  _GetMePositionUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getMePositionOnComplete != null);
    presenter.getMePositionOnComplete!;
  }

  @override
  void onError(e) {
    assert(presenter.getMePositionOnComplete != null);
    presenter.getMePositionOnError!(e);
  }

  @override
  void onNext(GetMePositionUseCaseResponse? response) {
    assert(presenter.getMePositionOnComplete != null);
    presenter.getMePositionOnNext!(response);
  }
}
