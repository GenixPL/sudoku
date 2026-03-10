import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cords.g.dart';

@JsonSerializable()
class Cords with EquatableMixin {
  const Cords({
    required this.x,
    required this.y,
  });

  const Cords.xy(this.x, this.y);

  factory Cords.fromJson(Map<String, dynamic> json) => _$CordsFromJson(json);

  Map<String, dynamic> toJson() => _$CordsToJson(this);

  @JsonKey(name: 'x')
  final int x;

  @JsonKey(name: 'y')
  final int y;

  @override
  List<Object?> get props => [
    x,
    y,
  ];
}
