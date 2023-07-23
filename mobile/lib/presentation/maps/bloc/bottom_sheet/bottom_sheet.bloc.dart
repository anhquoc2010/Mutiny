import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutiny/common/enums/handle_status.enum.dart';
import 'package:mutiny/data/models/address/recycle_bin.model.dart';
import 'package:mutiny/data/repositories/recycle_bin.repository.dart';

part 'bottom_sheet.event.dart';
part 'bottom_sheet.state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc({required RecycleBinRepository recycleBinRepository})
      : _recycleBinRepository = recycleBinRepository,
        super(const BottomSheetState.initial()) {
    on<BottomSheetGetRecycleBins>(_onGetRecycleBins);
  }
  final RecycleBinRepository _recycleBinRepository;

  Future<void> _onGetRecycleBins(
    BottomSheetGetRecycleBins event,
    Emitter<BottomSheetState> emit,
  ) async {
    emit(
      const BottomSheetState.loading(),
    );

    try {
      final List<RecycleBinModel> recycleBins =
          await _recycleBinRepository.getRecycleBins();

      emit(BottomSheetState.success(recycleBins: recycleBins));
    } catch (err) {
      emit(
        BottomSheetState.error(
          error: err.toString(),
        ),
      );
    }
  }
}
