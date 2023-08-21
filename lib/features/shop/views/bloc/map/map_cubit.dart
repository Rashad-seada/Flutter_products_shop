import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/di/app_module.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  void Function(GoogleMapController)? onMapCreated (GoogleMapController _controller) {
    controller.complete(_controller);
  }

  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  Future<void> goToLocation(CameraPosition newCameraPosition) async {
    final GoogleMapController _controller = await controller.future;
    await _controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> onTap() async {
    getCurrentLocation();
  }

  getCurrentLocation() async {
    getIt<Services>().locationService.getCurrentLocation().then(
            (value) {
              CameraPosition newPosition = CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(value.latitude, value.longitude),
                  tilt: 59.440717697143555,
                  zoom: 19.151926040649414);

              goToLocation(newPosition);

            });
  }
}
