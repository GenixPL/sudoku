import 'package:flutter/material.dart';
import 'package:sudoku/models/field.dart';

class FieldCell extends StatelessWidget {
  const FieldCell({
    super.key,
    required this.field,
  });

  final Field field;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Text('${field.x} ${field.y}'),
      ),
    );
  }
}
