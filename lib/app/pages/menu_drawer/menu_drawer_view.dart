import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:tw_app/app/pages/menu_drawer/menu_drawer_controller.dart';
import 'package:tw_app/app/utils/resources.dart';
import 'package:tw_app/data/repositories/local/data_local_authentication_repository.dart';
import 'package:tw_app/data/repositories/local/data_local_authentication_repository.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

class MenuDrawerPage extends clean.View {
  MenuDrawerPage({this.user, Key? key}) : super(key: key);
  Me? user;

  @override
  State<StatefulWidget> createState() => _MenuDrawerPageState(user);
}

class _MenuDrawerPageState
    extends clean.ViewState<MenuDrawerPage, MenuDrawerController> {
  _MenuDrawerPageState(Me? user)
      : super(MenuDrawerController(user, DataLocalAuthenticationRepository()));
  @override
  Widget get view {
    return clean.ControlledWidgetBuilder<MenuDrawerController>(
        builder: (context, controller) {
      return Drawer(
        key: globalKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                '${controller.user!.name}',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Salir'),
              onTap: () {
                controller.logout(context);
              },
            )
          ],
        ),
      );
    });
  }
}
