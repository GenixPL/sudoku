import 'package:equatable/equatable.dart';

class Cords with EquatableMixin {
  const Cords({
    required this.x,
    required this.y,
  });

  const Cords.xy(this.x, this.y);

  final int x;
  final int y;

  @override
  List<Object?> get props => [
    x,
    y,
  ];
}
