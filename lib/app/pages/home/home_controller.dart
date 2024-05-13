import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/app/pages.dart';
import 'package:tw_app/app/pages/home/home_presenter.dart';
import 'package:tw_app/data/repositories/remote/data_remote_position_repository.dart';
import 'package:tw_app/domain/entities/auth/me.dart';
import 'package:tw_app/domain/entities/position.dart';
import 'package:tw_app/domain/usecases/position/create_position_usecase.dart';
import 'package:tw_app/domain/usecases/position/get_me_position_usecase.dart';
import 'package:tw_app/domain/usecases/position/update_position_usecase.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeController extends Controller {
  late MapController mapController;
  Me? user;
  HomeController(
    Me? userData,
    DataRemotePositionRepository dataRemotePositionRepository,
  )   : presenter = HomePresenter(dataRemotePositionRepository),
        user = userData,
        mapController = MapController(),
        super();

  final HomePresenter presenter;
  Position? actualPosition;
  bool isGettingPosition = false;

  @override
  void onInitState() {
    // TODO: implement onInitState
    super.onInitState();
    presenter.getMePosition();
  }

  @override
  void initListeners() {
    presenter.createPositionOnNext = createPositionOnNext;
    presenter.createPositionOnError = (e) {
      print(e);
    };
    presenter.createPositionOnComplete = () {};

    presenter.updatePositionOnNext = updatePositionOnNext;
    presenter.updatePositionOnError = (e) {
      print(e);
    };
    presenter.updatePositionOnComplete = () {};

    presenter.getMePositionOnNext = getMePositionOnNext;
    presenter.getMePositionOnError = (e) {
    };
    presenter.getMePositionOnComplete = () {};
  }

  void createPositionOnNext(CreatePositionUseCaseResponse? response) {
    if (response != null) {
      refreshGetPosition(response.position!);
    }
  }

  void updatePositionOnNext(UpdatePositionUseCaseResponse? response) {
    if (response != null) {
      refreshGetPosition(response.position!);
    }
  }

  void getMePositionOnNext(GetMePositionUseCaseResponse? response) {
    print(response!.position!.toJson());
    if (response != null) {
      refreshGetPosition(response.position!);
    }
  }

  refreshGetPosition(Position position) {
    actualPosition = position;
    mapController.move(LatLng(position.lat!, position.lon!), 18.0);
    refreshUI();
  }

  Future<void> getDevicePosition() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    geo.Position pos = await geo.Geolocator.getCurrentPosition();
    if(actualPosition == null){
      print('creating');
      Position position = Position(lat: pos.latitude, lon: pos.longitude);
      print(position.toJson());
      presenter.createPosition(position);
    } else {
      print('updating');
      actualPosition!.lat = pos.latitude;
      actualPosition!.lon = pos.longitude;
      presenter.updatePosition(actualPosition!);
    }

    isGettingPosition = false;
    refreshUI();
  }
}
