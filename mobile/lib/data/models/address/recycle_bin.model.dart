import 'package:json_annotation/json_annotation.dart';
import 'package:mutiny/common/utils/json.util.dart';

part 'recycle_bin.model.g.dart';

@JsonSerializable(explicitToJson: true)
@JsonSerializableDateTime()
class RecycleBinModel {
  factory RecycleBinModel.fromJson(Map<String, dynamic> json) =>
      _$RecycleBinModelFromJson(json);

  RecycleBinModel({
    this.id,
    required this.name,
    required this.type,
    required this.address,
    this.specificAddress,
    required this.description,
    this.image,
    this.coordinate,
  });
  @JsonKey(includeIfNull: false)
  final int? id;
  final String name;
  final String type;
  final String? image;
  final String address;
  final String? specificAddress;
  final Map<String, double>? coordinate;
  final String? description;

  Map<String, dynamic> toJson() => _$RecycleBinModelToJson(this);
}
