// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recycle_bin.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecycleBinModel _$RecycleBinModelFromJson(Map<String, dynamic> json) =>
    RecycleBinModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      type: json['type'] as String,
      address: json['address'] as String,
      specificAddress: json['specificAddress'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      coordinate: (json['coordinate'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$RecycleBinModelToJson(RecycleBinModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['type'] = instance.type;
  val['image'] = instance.image;
  val['address'] = instance.address;
  val['specificAddress'] = instance.specificAddress;
  val['coordinate'] = instance.coordinate;
  val['description'] = instance.description;
  return val;
}
