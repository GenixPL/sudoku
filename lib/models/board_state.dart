import 'package:json_annotation/json_annotation.dart';

import '_models.dart';

part 'board_state.g.dart';

@JsonSerializable()
class BoardState {
  const BoardState({
    required this.blocks,
  });

  factory BoardState.fromJson(Map<String, dynamic> json) => _$BoardStateFromJson(json);

  Map<String, dynamic> toJson() => _$BoardStateToJson(this);

  @JsonKey(name: 'blocks')
  final List<Block> blocks;
}
