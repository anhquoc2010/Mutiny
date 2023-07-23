import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutiny/common/constants/constants.dart';
import 'package:mutiny/common/extensions/context_extension.dart';
import 'package:mutiny/common/utils/toast_util.dart';
import 'package:mutiny/data/repositories/place.repository.dart';
import 'package:mutiny/data/repositories/recycle_bin.repository.dart';
import 'package:mutiny/di/di.dart';
import 'package:mutiny/presentation/maps/maps.dart';
import 'package:mutiny/presentation/maps/widgets/maps_app_bar.widget.dart';
import 'package:mutiny/presentation/maps/widgets/maps_bottom_sheet.widget.dart';

class MapsPage extends StatelessWidget {
  MapsPage({super.key});
  final Completer<GoogleMapController> controller = Completer();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapsBloc(
            placeRepository: getIt.get<PlaceRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => BottomSheetBloc(
            recycleBinRepository: getIt.get<RecycleBinRepository>(),
          ),
        )
      ],
      child: BlocListener<MapsBloc, MapsState>(
        listener: (context, state) => _listenMapsStateChanged(context, state),
        child: _MapsView(
          controller: controller,
        ),
      ),
    );
  }

  Future<void> _listenMapsStateChanged(
    BuildContext context,
    MapsState state,
  ) async {
    if (state is MapsGetLocationSuccess) {
      GoogleMapController googleMapsController = await controller.future;
      googleMapsController.animateCamera(
        CameraUpdate.newLatLngZoom(
          state.myLocation ?? defaultLocation,
          12,
        ),
      );
    }
    if (state.error != null && context.mounted) {
      ToastUtil.showError(context, text: state.error);
    }
  }
}

class _MapsView extends StatefulWidget {
  const _MapsView({
    required this.controller,
  });
  final Completer<GoogleMapController> controller;

  @override
  State<_MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<_MapsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MapsAppBar(),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<MapsBloc, MapsState>(
        builder: (context, state) {
          return SizedBox(
            height: context.height,
            width: context.width,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: defaultLocation,
                zoom: 5,
              ),
              onMapCreated: (gController) {
                widget.controller.complete(gController);
              },
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              buildingsEnabled: false,
              markers: state.markers
                      ?.map(
                        (e) => Marker(
                          markerId: e.markerId,
                          position: e.position,
                          onTap: () {
                            _onClickMarker(context, e.position);
                          },
                        ),
                      )
                      .toSet() ??
                  const {},
            ),
          );
        },
      ),
    );
  }

  void _onClickMarker(BuildContext context, LatLng coordinate) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (ccontext) {
        return BlocProvider.value(
          value: context.read<BottomSheetBloc>()
            ..add(BottomSheetGetRecycleBins(coordinate: coordinate)),
          child: const RecycleBinBottomSheet(),
        );
      },
    );
  }
}
