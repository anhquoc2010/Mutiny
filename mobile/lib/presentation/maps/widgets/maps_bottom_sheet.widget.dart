import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutiny/common/enums/handle_status.enum.dart';
import 'package:mutiny/common/theme/text_styles.dart';
import 'package:mutiny/common/utils/conditional_render_util.dart';
import 'package:mutiny/common/widgets/bottom_sheet/sheet_header.dart';
import 'package:mutiny/presentation/maps/maps.dart';
import 'package:mutiny/presentation/maps/widgets/list_marker_recycle_bin.widget.dart';

class RecycleBinBottomSheet extends StatelessWidget {
  const RecycleBinBottomSheet({
    super.key,
    required this.destination,
    required this.polylineCoordinates,
    required this.getPolyPoints,
    required this.setDestination,
  });

  final LatLng destination;
  final List<LatLng> polylineCoordinates;
  final Function(MapsState state, List<LatLng> polylineCoordinates) getPolyPoints;
  final Function(LatLng destination) setDestination;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverFillRemaining(
              fillOverscroll: true,
              child: Column(
                children: [
                  const SheetHeader(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
                      builder: (context, state) {
                        return ConditionalRenderUtil.single(
                          context,
                          value: state.status,
                          caseBuilders: {
                            HandleStatus.loading: (_) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                            HandleStatus.error: (_) => Center(
                                  child: Text(
                                    state.error!,
                                    style: TextStyles.s17RegularText,
                                  ),
                                ),
                            HandleStatus.success: (_) {
                              return ListMarkerRecycleBins(
                                destination: destination,
                                polylineCoordinates: polylineCoordinates,
                                getPolyPoints: getPolyPoints,
                                setDestination: setDestination,
                              );
                            }
                          },
                          fallbackBuilder: (_) => ListMarkerRecycleBins(
                            destination: destination,
                            polylineCoordinates: polylineCoordinates,
                            getPolyPoints: getPolyPoints,
                            setDestination: setDestination,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
