// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recycle_bin.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecycleBinModel _$RecycleBinModelFromJson(Map<String, dynamic> json) =>
    RecycleBinModel(
      bounds: BoundsModel.fromJson(json['bounds'] as Map<String, dynamic>),
      legs: (json['legs'] as List<dynamic>)
          .map((e) => LegsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      overviewPolyline: OverviewPolylineModel.fromJson(
          json['overview_polyline'] as Map<String, dynamic>),
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$RecycleBinModelToJson(RecycleBinModel instance) =>
    <String, dynamic>{
      'bounds': instance.bounds.toJson(),
      'legs': instance.legs.map((e) => e.toJson()).toList(),
      'overview_polyline': instance.overviewPolyline.toJson(),
      'summary': instance.summary,
    };

BoundsModel _$BoundsModelFromJson(Map<String, dynamic> json) => BoundsModel(
      northeast:
          CoordinateModel.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest:
          CoordinateModel.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoundsModelToJson(BoundsModel instance) =>
    <String, dynamic>{
      'northeast': instance.northeast.toJson(),
      'southwest': instance.southwest.toJson(),
    };

LegsModel _$LegsModelFromJson(Map<String, dynamic> json) => LegsModel(
      distance:
          DistanceModel.fromJson(json['distance'] as Map<String, dynamic>),
      duration:
          DurationModel.fromJson(json['duration'] as Map<String, dynamic>),
      durationInTraffic: DurationModel.fromJson(
          json['durationInTraffic'] as Map<String, dynamic>),
      startAddress: json['startAddress'] as String,
      endAddress: json['endAddress'] as String,
      startLocation: CoordinateModel.fromJson(
          json['startLocation'] as Map<String, dynamic>),
      endLocation:
          CoordinateModel.fromJson(json['endLocation'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LegsModelToJson(LegsModel instance) => <String, dynamic>{
      'distance': instance.distance.toJson(),
      'duration': instance.duration.toJson(),
      'durationInTraffic': instance.durationInTraffic.toJson(),
      'startAddress': instance.startAddress,
      'endAddress': instance.endAddress,
      'startLocation': instance.startLocation.toJson(),
      'endLocation': instance.endLocation.toJson(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
    };

OverviewPolylineModel _$OverviewPolylineModelFromJson(
        Map<String, dynamic> json) =>
    OverviewPolylineModel(
      points: json['points'] as String,
    );

Map<String, dynamic> _$OverviewPolylineModelToJson(
        OverviewPolylineModel instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

DistanceModel _$DistanceModelFromJson(Map<String, dynamic> json) =>
    DistanceModel(
      text: json['text'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$DistanceModelToJson(DistanceModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

DurationModel _$DurationModelFromJson(Map<String, dynamic> json) =>
    DurationModel(
      text: json['text'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$DurationModelToJson(DurationModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

StepsModel _$StepsModelFromJson(Map<String, dynamic> json) => StepsModel(
      distance:
          DistanceModel.fromJson(json['distance'] as Map<String, dynamic>),
      duration:
          DurationModel.fromJson(json['duration'] as Map<String, dynamic>),
      durationInTraffic: DurationModel.fromJson(
          json['duration_in_traffic'] as Map<String, dynamic>),
      startLocation: CoordinateModel.fromJson(
          json['start_location'] as Map<String, dynamic>),
      endLocation: CoordinateModel.fromJson(
          json['end_location'] as Map<String, dynamic>),
      htmlInstructions: json['html_instructions'] as String,
    );

Map<String, dynamic> _$StepsModelToJson(StepsModel instance) =>
    <String, dynamic>{
      'distance': instance.distance.toJson(),
      'duration': instance.duration.toJson(),
      'duration_in_traffic': instance.durationInTraffic.toJson(),
      'start_location': instance.startLocation.toJson(),
      'end_location': instance.endLocation.toJson(),
      'html_instructions': instance.htmlInstructions,
    };
