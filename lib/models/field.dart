sealed class Field {
  final int x;
  final int y;

  const Field({
    required this.x,
    required this.y,
  });

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
