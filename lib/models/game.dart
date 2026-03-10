import 'package:sudoku/models/_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  const Game({
    required this.id,
    required this.states,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  @JsonKey(name: 'id')
  final String id;

  DateTime get createdAt {
    return DateTime.parse(id.split('_').last);
  }

  @JsonKey(name: 'states')
  final List<BoardState> states;
}
