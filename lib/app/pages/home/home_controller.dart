import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/home/home_presenter.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

class HomeController extends Controller {
  Me? user;
  HomeController(Me? userData)
      : presenter = HomePresenter(),
        user = userData,
        super();

  final HomePresenter presenter;

  @override
  void onInitState() {
    // TODO: implement onInitState
    super.onInitState();
  }

  @override
  void initListeners() {}
}
