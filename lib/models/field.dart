import 'package:collection/collection.dart';
import 'package:sudoku/models/_models.dart';

extension FieldListExtension on List<Field> {
  Field getByCords(Cords cords) {
    return firstWhere((f) => f.blockCords == cords);
  }

  Field? tryGetByCords(Cords? cords) {
    return firstWhereOrNull((f) => f.blockCords == cords);
  }
}

sealed class Field {
  const Field({
    required this.blockCords,
    required this.absoluteCords,
  });

  static List<Field> createEmptyList(Cords blockCords) {
    return [
      for (int x = 0; x < 3; x++)
        for (int y = 0; y < 3; y++)
          EmptyField(
            blockCords: Cords(
              x: x,
              y: y,
            ),
            absoluteCords: Cords(
              x: blockCords.x * 3 + x,
              y: blockCords.y * 3 + y,
            ),
          ),
    ];
  }

  final Cords blockCords;
  final Cords absoluteCords;

  EmptyField clear() {
    return EmptyField(
      blockCords: blockCords,
      absoluteCords: absoluteCords,
    );
  }

  FilledField filled(int number) {
    return FilledField(
      number: number,
      blockCords: blockCords,
      absoluteCords: absoluteCords,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Field && other.absoluteCords == absoluteCords;
  }

  @override
  int get hashCode => Object.hashAll([absoluteCords]);
}

class EmptyField extends Field {
  const EmptyField({
    required super.blockCords,
    required super.absoluteCords,
  });
}

class NotesField extends Field {
  const NotesField({
    required this.numbers,
    required super.blockCords,
    required super.absoluteCords,
  });

  final List<int> numbers;
}

class FilledField extends Field {
  const FilledField({
    required this.number,
    required super.blockCords,
    required super.absoluteCords,
  });

  final int number;
}
