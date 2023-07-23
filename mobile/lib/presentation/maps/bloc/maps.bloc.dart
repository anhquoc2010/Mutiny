import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutiny/common/constants/constants.dart';
import 'package:mutiny/data/repositories/place.repository.dart';
import 'package:permission_handler/permission_handler.dart';

part 'maps.event.dart';
part 'maps.state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc({
    required PlaceRepository placeRepository,
  })  : _placeRepository = placeRepository,
        super(
          const MapsState.initial(),
        ) {
    on<MapsPermissionRequest>(_onRequestPermission);
    on<MapsMarkersGet>(_onGetMarkers);
    add(MapsPermissionRequest());
    add(const MapsMarkersGet());
  }
  final PlaceRepository _placeRepository;

  Future<LatLng> _getMyLocation(Emitter<MapsState> emiiter) async {
    try {
      final Position userPosition = await Geolocator.getCurrentPosition();

      return LatLng(userPosition.latitude, userPosition.longitude);
    } catch (err) {
      log('Error in get user location');
      emiiter(
        state.copyWith(
          error: err.toString(),
        ),
      );

      return defaultLocation;
    }
  }

  Future<void> _onRequestPermission(
    MapsPermissionRequest event,
    Emitter<MapsState> emiiter,
  ) async {
    final bool isGranted = await Permission.location.isGranted;

    if (!isGranted) {
      await Permission.location.request();
    }

    emiiter(
      MapsGetLocationSuccess(
        myLocation: await _getMyLocation(emiiter),
        markers: state.markers ?? const {},
      ),
    );
  }

  Future<void> _onGetMarkers(
    MapsMarkersGet event,
    Emitter<MapsState> emiiter,
  ) async {
    try {
      final response = await _getMyLocation(emiiter);
      emiiter(
        state.copyWith(
          markers: {
            Marker(
              markerId: const MarkerId('myLocation'),
              position: response,
            ),
          },
        ),
      );
    } catch (e) {
      log('Error in get markers');
      emiiter(
        state.copyWith(
          error: e.toString(),
        ),
      );
    }
  }
}
