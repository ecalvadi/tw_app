import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:tw_app/app/pages/home/home_controller.dart';
import 'package:tw_app/app/pages/menu_drawer/menu_drawer_view.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

class HomePage extends clean.View {
  HomePage({this.user, Key? key}) : super(key: key);
  Me? user;

  @override
  State<StatefulWidget> createState() => _HomePageState(user);
}

class _HomePageState extends clean.ViewState<HomePage, HomeController> {
  _HomePageState(Me? user) : super(HomeController(user));

  @override
  Widget get view {
    return clean.ControlledWidgetBuilder<HomeController>(
        builder: (BuildContext context, HomeController controller) {
      return Scaffold(
        key: globalKey,
        appBar: AppBar(
          elevation: 0,
          title: Text('TW Demo APP'),
        ),
        drawer: MenuDrawerPage(
          user: controller.user,
        ),
        body: Center(
          child: Text('Bienvenido ${controller.user!.name}'),
        ),
      );
    });
  }
}
