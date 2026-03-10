import 'package:collection/collection.dart';
import 'package:sudoku/models/_models.dart';

extension FieldListExtension on List<Field> {
  Field getByCords(Cords cords) {
    return firstWhere((f) => f.cords == cords);
  }

  Field? tryGetByCords(Cords? cords) {
    return firstWhereOrNull((f) => f.cords == cords);
  }
}

sealed class Field {
  const Field({
    required this.cords,
  });

  static List<Field> createEmptyList() {
    return [
      for (int x = 0; x < 3; x++)
        for (int y = 0; y < 3; y++)
          EmptyField(
            cords: Cords(
              x: x,
              y: y,
            ),
          ),
    ];
  }

  final Cords cords;

  EmptyField clear() {
    return EmptyField(
      cords: cords,
    );
  }

  FilledField filled(int number) {
    return FilledField(
      number: number,
      cords: cords,
    );
  }

  Cords absoluteCords(Block block) {
    return Cords(
      x: block.cords.x * 3 + cords.x,
      y: block.cords.y * 3 + cords.y,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Field && other.cords == cords;
  }

  @override
  int get hashCode => Object.hashAll([cords]);
}

class EmptyField extends Field {
  const EmptyField({
    required super.cords,
  });
}

class NotesField extends Field {
  const NotesField({
    required this.numbers,
    required super.cords,
  });

  final List<int> numbers;
}

class FilledField extends Field {
  const FilledField({
    required this.number,
    required super.cords,
  });

  final int number;
}
