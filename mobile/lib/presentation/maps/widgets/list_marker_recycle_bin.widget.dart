import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutiny/common/widgets/common_text_form_field.dart';
import 'package:mutiny/presentation/maps/maps.dart';
import 'package:mutiny/presentation/maps/widgets/recycle_bin_item.widget.dart';
import 'package:mutiny/router/app_router.dart';

class ListMarkerRecycleBins extends StatelessWidget {
  ListMarkerRecycleBins({
    super.key,
    required this.destination,
    required this.polylineCoordinates,
    required this.getPolyPoints,
    required this.setDestination,
  });
  final LatLng destination;
  final List<LatLng> polylineCoordinates;
  final Function(MapsState state, List<LatLng> polylineCoordinates)
      getPolyPoints;
  final Function(LatLng destination) setDestination;

  final TextEditingController originController = TextEditingController();

  Future<void> _setAddress(BuildContext context) async {
    final Map<String, dynamic>? result = (await Navigator.of(context)
        .pushNamed(AppRouter.locationSearch) as Map<String, dynamic>?);

    if (result != null) {
      originController.text = result['description']! as String;
      setDestination(result['destination']! as LatLng);
    }

    getPolyPoints(
      context.read<MapsBloc>().state,
      polylineCoordinates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                CommonTextFormField(
                  readOnly: true,
                  textController: originController,
                  hintText: 'Điểm đến',
                  borderRadius: 30,
                  borderColor: Colors.grey,
                  prefixIcon: Icons.location_on_rounded,
                  hintColor: Colors.grey,
                  onTap: () async {
                    await _setAddress(context);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const RecycleBinItem();
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 0,
        ),
      ],
    );
  }
}
