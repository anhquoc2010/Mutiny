import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'maps.event.dart';
part 'maps.state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(const MapsState()) {
    on<MapsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
