import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class PlaceModel {
  final String description;
  final String placeId;
  final List<String> types;
  @JsonKey(fromJson: LatLng.fromJson)
  final LatLng? location;

  PlaceModel({
    required this.description,
    required this.placeId,
    required this.types,
    this.location,
  });

  //copyWith
  PlaceModel copyWith({
    String? description,
    String? placeId,
    List<String>? types,
    LatLng? location,
  }) {
    return PlaceModel(
      description: description ?? this.description,
      placeId: placeId ?? this.placeId,
      types: types ?? this.types,
      location: location ?? this.location,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
