import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tw_app/app/pages/home/home_controller.dart';
import 'package:tw_app/app/pages/menu_drawer/menu_drawer_view.dart';
import 'package:tw_app/app/utils/resources.dart';
import 'package:tw_app/data/repositories/remote/data_remote_position_repository.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

class HomePage extends clean.View {
  HomePage({this.user, Key? key}) : super(key: key);
  Me? user;

  @override
  State<StatefulWidget> createState() => _HomePageState(user);
}

class _HomePageState extends clean.ViewState<HomePage, HomeController> {
  _HomePageState(Me? user)
      : super(HomeController(
          user,
          DataRemotePositionRepository(),
        ));

  @override
  Widget get view {
    return clean.ControlledWidgetBuilder<HomeController>(
        builder: (BuildContext context, HomeController controller) {
      return Scaffold(
        key: Key('homePage'),
        appBar: AppBar(
          elevation: 0,
          title: Text('TW Demo APP'),
        ),
        drawer: MenuDrawerPage(
          user: controller.user,
        ),
        body: FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
            initialCenter: LatLng(controller.actualPosition?.lat??0, controller.actualPosition?.lon??0),
            initialZoom: 2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),

            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(controller.actualPosition?.lat??0, controller.actualPosition?.lon??0),
                  width: 80,
                  height: 80,
                  child: Image(image: AssetImage(Resources.pinMarker)),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.isGettingPosition = true;
            setState(() {});
            controller.getDevicePosition();
          },
          child: (controller.isGettingPosition)
              ? CircularProgressIndicator()
              : Icon(Icons.pin_drop_outlined),
          tooltip: 'Presionar para actualizar su ubicaión',
        ),
      );
    });
  }
}
