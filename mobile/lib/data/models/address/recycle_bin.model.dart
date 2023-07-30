import 'package:json_annotation/json_annotation.dart';
import 'package:mutiny/common/utils/json.util.dart';

import 'package:mutiny/data/models/address/coordinate.model.dart';

part 'recycle_bin.model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
@JsonSerializableDateTime()
class RecycleBinModel {
  factory RecycleBinModel.fromJson(Map<String, dynamic> json) =>
      _$RecycleBinModelFromJson(json);

  RecycleBinModel({
    required this.bounds,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
  });

  final BoundsModel bounds;
  final List<LegsModel> legs;
  final OverviewPolylineModel overviewPolyline;
  final String summary;

  Map<String, dynamic> toJson() => _$RecycleBinModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class BoundsModel {
  factory BoundsModel.fromJson(Map<String, dynamic> json) =>
      _$BoundsModelFromJson(json);

  BoundsModel({
    required this.northeast,
    required this.southwest,
  });
  final CoordinateModel northeast;
  final CoordinateModel southwest;

  Map<String, dynamic> toJson() => _$BoundsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LegsModel {
  factory LegsModel.fromJson(Map<String, dynamic> json) =>
      _$LegsModelFromJson(json);

  LegsModel({
    required this.distance,
    required this.duration,
    required this.durationInTraffic,
    required this.startAddress,
    required this.endAddress,
    required this.startLocation,
    required this.endLocation,
    required this.steps,
  });
  final DistanceModel distance;
  final DurationModel duration;
  final DurationModel durationInTraffic;
  final String startAddress;
  final String endAddress;
  final CoordinateModel startLocation;
  final CoordinateModel endLocation;
  final List<StepsModel> steps;

  Map<String, dynamic> toJson() => _$LegsModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OverviewPolylineModel {
  factory OverviewPolylineModel.fromJson(Map<String, dynamic> json) =>
      _$OverviewPolylineModelFromJson(json);

  OverviewPolylineModel({
    required this.points,
  });
  final String points;

  Map<String, dynamic> toJson() => _$OverviewPolylineModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DistanceModel {
  factory DistanceModel.fromJson(Map<String, dynamic> json) =>
      _$DistanceModelFromJson(json);

  DistanceModel({
    required this.text,
    required this.value,
  });
  final String text;
  final int value;

  Map<String, dynamic> toJson() => _$DistanceModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DurationModel {
  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      _$DurationModelFromJson(json);

  DurationModel({
    required this.text,
    required this.value,
  });
  final String text;
  final int value;

  Map<String, dynamic> toJson() => _$DurationModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class StepsModel {
  factory StepsModel.fromJson(Map<String, dynamic> json) =>
      _$StepsModelFromJson(json);

  StepsModel({
    required this.distance,
    required this.duration,
    required this.durationInTraffic,
    required this.startLocation,
    required this.endLocation,
    required this.htmlInstructions,
  });
  final DistanceModel distance;
  final DurationModel duration;
  final DurationModel durationInTraffic;
  final CoordinateModel startLocation;
  final CoordinateModel endLocation;
  final String htmlInstructions;

  Map<String, dynamic> toJson() => _$StepsModelToJson(this);
}
