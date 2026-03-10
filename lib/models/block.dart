import 'package:equatable/equatable.dart';
import 'package:sudoku/models/_models.dart';

extension BlockListExtension on List<Block> {
  Block getByCords({
    required int x,
    required int y,
  }) {
    return firstWhere((b) => (b.x == x) && (b.y == y));
  }
}

class Block with EquatableMixin {
  const Block({
    required this.x,
    required this.y,
    required this.fields,
  });

  static List<Block> createList() {
    return [
      for (int x = 0; x < 3; x++)
        for (int y = 0; y < 3; y++)
          Block(
            x: x,
            y: y,
            fields: EmptyField.createList(),
          ),
    ];
  }

  final int x;
  final int y;
  final List<Field> fields;

  @override
  List<Object?> get props => [
    x,
    y,
  ];
}
