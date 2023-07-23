part of 'maps.bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object?> get props => [];
}

class MapsPermissionRequest extends MapsEvent {}

class MapsMarkersGet extends MapsEvent {
  const MapsMarkersGet();

  @override
  List<Object?> get props => [];
}

class MapsProjectsGet extends MapsEvent {
  const MapsProjectsGet();

  @override
  List<Object?> get props => [];
}
