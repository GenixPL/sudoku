import 'package:flutter/material.dart';
import 'package:sudoku/models/block.dart';
import 'package:sudoku/models/field.dart';
import 'package:sudoku/widgets/_widgets.dart';
import 'package:sudoku/widgets/ui_consts.dart';

class FieldCell extends StatelessWidget {
  const FieldCell({
    super.key,
    required this.activeBlock,
    required this.activeField,
    required this.field,
    required this.block,
    required this.onFieldTap,
  });

  final OnFieldTap onFieldTap;
  final Field? activeField;
  final Block? activeBlock;
  final Block block;
  final Field field;

  @override
  Widget build(BuildContext context) {
    final Field field = this.field;

    return GestureDetector(
      onTap: () => onFieldTap(block, field),
      child: Container(
        color: _getColor(context),
        child: AspectRatio(
          aspectRatio: 1,
          child: switch (field) {
            EmptyField() => const SizedBox(),
            NotesField() => Text('N'),
            FilledField() => Text(field.number.toString()),
          },
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    final Field? activeField = this.activeField;
    final Block? activeBlock = this.activeBlock;
    if (activeBlock == null || activeField == null) {
      return Colors.transparent;
    }

    final Color color = Theme.of(context).primaryColor;

    final bool isActive = (activeField == field) && (activeBlock == block);
    if (isActive) {
      return color.withAlpha((255 * 0.66).toInt());
    }

    if (block == activeBlock) {
      return color.third;
    }

    if (field.absoluteX(block) == activeField.absoluteX(activeBlock)) {
      return color.third;
    }

    if (field.absoluteY(block) == activeField.absoluteY(activeBlock)) {
      return color.third;
    }

    return Colors.transparent;
  }
}

extension _ColorExtensions on Color {
  Color get third {
    return withAlpha((255 * 0.33).toInt());
  }
}
