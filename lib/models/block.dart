import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/models/_models.dart';

extension BlockListExtension on List<Block> {
  Block getByCords(Cords cords) {
    return firstWhere((b) => b.cords == cords);
  }

  Block? tryGetByCords(Cords? cords) {
    return firstWhereOrNull((b) => b.cords == cords);
  }
}

class Block with EquatableMixin {
  const Block({
    required this.cords,
    required this.fields,
  });

  static List<Block> createList() {
    return [
      for (int x = 0; x < 3; x++)
        for (int y = 0; y < 3; y++)
          Block(
            cords: Cords.xy(x, y),
            fields: Field.createEmptyList(),
          ),
    ];
  }

  final Cords cords;
  final List<Field> fields;

  Block withUpdatedFiled(Field field) {
    return Block(
      cords: cords,
      fields: fields.toList()
        ..removeWhere((f) => f == field)
        ..add(field),
    );
  }

  @override
  List<Object?> get props => [
    cords,
  ];
}
