extension FieldListExtension on List<Field> {
  Field getByCords({
    required int x,
    required int y,
  }) {
    return firstWhere((f) => (f.x == x) && (f.y == y));
  }
}

sealed class Field {
  const Field({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  EmptyField clear() {
    return EmptyField(
      x: x,
      y: y,
    );
  }
}

class EmptyField extends Field {
  const EmptyField({
    required super.x,
    required super.y,
  });

  static List<EmptyField> createList() {
    return [
      for (int x = 0; x < 3; x++)
        for (int y = 0; y < 3; y++)
          EmptyField(
            x: x,
            y: y,
          ),
    ];
  }
}

class NotesField extends Field {
  const NotesField({
    required this.numbers,
    required super.x,
    required super.y,
  });

  final List<int> numbers;
}

class FilledField extends Field {
  const FilledField({
    required this.number,
    required super.x,
    required super.y,
  });

  final int number;
}
