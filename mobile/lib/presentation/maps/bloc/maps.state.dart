part of 'maps.bloc.dart';

class MapsState extends Equatable {
  const MapsState.initial()
      : this(
          myLocation: const LatLng(18.635370, 105.737148),
          markers: const {},
        );
  const MapsState({
    this.myLocation,
    this.markers,
    this.error,
  });

  final LatLng? myLocation;
  final Set<Marker>? markers;
  final String? error;

  MapsState copyWith({
    LatLng? myLocation,
    Set<Marker>? markers,
    String? error,
  }) {
    return MapsState(
      myLocation: myLocation ?? this.myLocation,
      markers: markers ?? this.markers,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        myLocation,
        markers,
        error,
      ];
}

class MapsGetLocationSuccess extends MapsState {
  const MapsGetLocationSuccess({
    required LatLng myLocation,
    required Set<Marker> markers,
  }) : super(myLocation: myLocation, markers: markers);
}
