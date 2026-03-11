// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
  cords: Cords.fromJson(json['cords'] as Map<String, dynamic>),
  fields: Field.fromJson(json['fields'] as List),
);

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
  'cords': instance.cords,
  'fields': Field.toJson(instance.fields),
};
