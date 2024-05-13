import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:tw_app/app/pages/loading/loading_controller.dart';
import 'package:tw_app/app/utils/resources.dart';
import 'package:tw_app/data/repositories/local/data_local_authentication_repository.dart';
import 'package:tw_app/data/repositories/remote/data_remote_authentication_repository.dart';

class LoadingPage extends clean.View {
  LoadingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingPageState();
}

class _LoadingPageState extends clean.ViewState<LoadingPage, LoadingController>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCtrl =
      AnimationController(vsync: this, duration: Duration(seconds: 10))
        ..repeat(period: const Duration(seconds: 5));

  _LoadingPageState()
      : super(LoadingController(DataLocalAuthenticationRepository(),
            DataRemoteAuthenticationRepository()));

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget get view {
    return clean.ControlledWidgetBuilder<LoadingController>(
        builder: (context, controller) {
      return Scaffold(
        key: globalKey,
        body: Container(
          color: Colors.blue[100],
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(animCtrl),
                child: const Image(
                  image: AssetImage(Resources.logo),
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
