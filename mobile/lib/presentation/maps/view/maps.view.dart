import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutiny/common/constants/constants.dart';
import 'package:mutiny/common/extensions/context_extension.dart';
import 'package:mutiny/common/utils/toast_util.dart';
import 'package:mutiny/data/repositories/recycle_bin.repository.dart';
import 'package:mutiny/di/di.dart';
import 'package:mutiny/flavors.dart';
import 'package:mutiny/presentation/maps/maps.dart';
import 'package:mutiny/presentation/maps/widgets/maps_app_bar.widget.dart';
import 'package:mutiny/presentation/maps/widgets/maps_bottom_sheet.widget.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> controller = Completer();

  late LatLng destination;

  late List<LatLng> polylineCoordinates = [];

  void _setDestination(LatLng destination) {
    this.destination = destination;
    setState(() {});
  }

  void _getPolyPoints(MapsState state, List<LatLng> polylineCoordinates) async {
    PolylinePoints polylinePoints = PolylinePoints();


    this.polylineCoordinates = polylineCoordinates;
    setState(() {});
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppFlavor.googleMapApiKey,
      PointLatLng(state.myLocation!.latitude, state.myLocation!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    
    this.polylineCoordinates = polylineCoordinates;
    setState(() {});

    if (result.points.isNotEmpty) {
      polylineCoordinates = [];
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
        
        this.polylineCoordinates = polylineCoordinates;
        setState(() {});
      }
    }
    this.polylineCoordinates = polylineCoordinates;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapsBloc(),
        ),
        BlocProvider(
          create: (context) => BottomSheetBloc(
            recycleBinRepository: getIt.get<RecycleBinRepository>(),
          ),
        ),
      ],
      child: BlocListener<MapsBloc, MapsState>(
        listener: (context, state) => _listenMapsStateChanged(context, state),
        child: _MapsView(
          controller: controller,
          destination: destination,
          polylineCoordinates: polylineCoordinates,
          getPolyPoints: _getPolyPoints,
          setDestination: _setDestination,
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
          17,
        ),
      );
    }

    if (state.error != null && context.mounted) {
      ToastUtil.showError(context, text: state.error);
    }
  }

  @override
  void initState() {
    super.initState();
    _getPolyPoints(const MapsState.initial(), polylineCoordinates);
    _setDestination(defaultLocation);
  }
}

class _MapsView extends StatefulWidget {
  const _MapsView({
    required this.controller,
    required this.destination,
    required this.polylineCoordinates,
    required this.getPolyPoints,
    required this.setDestination,
  });
  final Completer<GoogleMapController> controller;
  final LatLng destination;
  final List<LatLng> polylineCoordinates;
  final Function(MapsState state, List<LatLng> polylineCoordinates) getPolyPoints;
  final Function(LatLng destination) setDestination;

  @override
  State<_MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<_MapsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MapsAppBar(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom + context.paddingBottom,
        ),
        child: RecycleBinBottomSheet(
          destination: widget.destination,
          polylineCoordinates: widget.polylineCoordinates,
          getPolyPoints: widget.getPolyPoints,
          setDestination: widget.setDestination,
        ),
      ),
      // bottomSheet: BlocBuilder<BottomSheetBloc, BottomSheetState>(
      //   buildWhen: (previous, current) => previous != current,
      //   builder: (context, state) {
      //     _onInitBottomSheet(
      //       context,
      //     );
      //     return const SizedBox.shrink();
      //   },
      // ),
      body: BlocBuilder<MapsBloc, MapsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return SizedBox(
            height: context.height,
            width: context.width,
            child: GoogleMap(
              padding: const EdgeInsets.only(top: 100),
              initialCameraPosition: const CameraPosition(
                target: defaultLocation,
                zoom: 5,
              ),
              onMapCreated: (gController) {
                widget.controller.complete(gController);
              },
              myLocationEnabled: true,
              trafficEnabled: true,
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: Colors.red,
                  width: 5,
                  points: widget.polylineCoordinates,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId('source'),
                  position: state.myLocation ?? defaultLocation,
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: widget.destination,
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
