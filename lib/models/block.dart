import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sudoku/models/_models.dart';

part 'block.g.dart';

extension BlockListExtension on List<Block> {
  Block getByBlockCords(Cords blockCords) {
    return firstWhere((b) => b.cords == blockCords);
  }

  Block? tryGetByBlockCords(Cords? blockCords) {
    return firstWhereOrNull((b) => b.cords == blockCords);
  }

  Block getByAbsoluteCords(Cords absoluteCords) {
    final int x = absoluteCords.x;
    final int y = absoluteCords.y;

    // Top row
    if (0 <= y && y <= 2) {
      // Left column
      if (0 <= x && x <= 2) {
        return getByBlockCords(Cords.xy(0, 0));
      }

      // Middle column
      if (3 <= x && x <= 5) {
        return getByBlockCords(Cords.xy(1, 0));
      }

      // Right column
      if (6 <= x && x <= 8) {
        return getByBlockCords(Cords.xy(2, 0));
      }

      throw 'Wrong x value ($x)!';
    }

    // Middle row
    if (3 <= y && y <= 5) {
      // Left column
      if (0 <= x && x <= 2) {
        return getByBlockCords(Cords.xy(0, 1));
      }

      // Middle column
      if (3 <= x && x <= 5) {
        return getByBlockCords(Cords.xy(1, 1));
      }

      // Right column
      if (6 <= x && x <= 8) {
        return getByBlockCords(Cords.xy(2, 1));
      }

      throw 'Wrong x value ($x)!';
    }

    // Bottom row
    if (6 <= y && y <= 8) {
      // Left column
      if (0 <= x && x <= 2) {
        return getByBlockCords(Cords.xy(0, 2));
      }

      // Middle column
      if (3 <= x && x <= 5) {
        return getByBlockCords(Cords.xy(1, 2));
      }

      // Right column
      if (6 <= x && x <= 8) {
        return getByBlockCords(Cords.xy(2, 2));
      }

      throw 'Wrong x value ($x)!';
    }

    throw 'Wrong y value ($y)!';
  }

  List<Field> getAllFields() {
    return [
      for (Block block in this) ...block.fields,
    ];
  }

  bool hasError(FilledField filledField) {
    // Check given block
    final Block block = getByAbsoluteCords(filledField.absoluteCords);
    for (Field field in block.fields) {
      switch (field) {
        case EmptyField():
        case NotesField():
          continue;

        case FilledField():
          if (field.number == filledField.number && field != filledField) {
            return true;
          }
      }
    }

    // Check rows and columns
    for (Field field in getAllFields()) {
      if (field.absoluteCords.x != filledField.absoluteCords.x &&
          field.absoluteCords.y != filledField.absoluteCords.y) {
        continue;
      }

      switch (field) {
        case EmptyField():
        case NotesField():
          continue;

        case FilledField():
          if (field != filledField && field.number == filledField.number) {
            return true;
          }
      }
    }

    return false;
  }
}

@JsonSerializable()
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
            fields: Field.createEmptyList(Cords.xy(x, y)),
          ),
    ];
  }

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);

  Map<String, dynamic> toJson() => _$BlockToJson(this);

  @JsonKey(name: 'cords')
  final Cords cords;

  @JsonKey(
    name: 'fields',
    fromJson: Field.fromJson,
    toJson: Field.toJson,
  )
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
