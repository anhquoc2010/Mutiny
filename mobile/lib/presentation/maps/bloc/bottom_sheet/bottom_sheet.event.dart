part of 'bottom_sheet.bloc.dart';

abstract class BottomSheetEvent extends Equatable {
  const BottomSheetEvent();

  @override
  List<Object> get props => [];
}

class BottomSheetGetRecycleBins extends BottomSheetEvent {
  const BottomSheetGetRecycleBins({required this.coordinate});

  final LatLng coordinate;

  @override
  List<Object> get props => [coordinate];
}
