import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fca;
import 'package:tw_app/app/pages/splash/splash_controller.dart';
import 'package:tw_app/app/utils/resources.dart';

class SplashPage extends fca.View {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends fca.ViewState<SplashPage, SplashController> {
  _SplashPageState() : super(SplashController()); //Agregar controller
  @override
  Widget get view {
    return fca.ControlledWidgetBuilder<SplashController>(
        builder: (context, controller) {
      return Scaffold(
        key: globalKey,
        body: Container(
          color: Colors.blue[100],
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Image(
                image: AssetImage(Resources.logo),
                height: 100,
              ),
            ),
          ),
        ),
      );
    });
  }
}
