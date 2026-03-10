// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardState _$BoardStateFromJson(Map<String, dynamic> json) => BoardState(
  blocks: (json['blocks'] as List<dynamic>)
      .map((e) => Block.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BoardStateToJson(BoardState instance) =>
    <String, dynamic>{'blocks': instance.blocks};
