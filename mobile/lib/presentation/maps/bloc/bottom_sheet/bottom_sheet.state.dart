part of 'bottom_sheet.bloc.dart';

class BottomSheetState extends Equatable {
  const BottomSheetState._({
    this.recycleBins = const [],
    this.error,
    this.status = HandleStatus.initial,
  });

  final List<RecycleBinModel> recycleBins;
  final String? error;
  final HandleStatus status;

  const BottomSheetState.initial() : this._(status: HandleStatus.initial);

  const BottomSheetState.loading() : this._(status: HandleStatus.loading);

  const BottomSheetState.error({required String error})
      : this._(error: error, status: HandleStatus.error);

  const BottomSheetState.success({required List<RecycleBinModel> recycleBins})
      : this._(recycleBins: recycleBins, status: HandleStatus.success);

  @override
  List<Object> get props => [];
}
