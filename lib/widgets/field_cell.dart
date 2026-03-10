import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class FieldCell extends StatelessWidget {
  const FieldCell({
    super.key,
    required this.activeBlock,
    required this.activeField,
    required this.field,
    required this.blocks,
    required this.block,
    required this.highlightRowsAndColumns,
    required this.onFieldTap,
  });

  final OnFieldTap onFieldTap;
  final Field? activeField;
  final Block? activeBlock;
  final List<Block> blocks;
  final bool highlightRowsAndColumns;
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
          child: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              return switch (field) {
                EmptyField() => const SizedBox(),
                NotesField() => Text('N'),
                FilledField() => _buildFilled(
                  filledField: field,
                  maxSize: constraints.maxHeight,
                ),
              };
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilled({
    required FilledField filledField,
    required double maxSize,
  }) {
    return Center(
      child: Text(
        filledField.number.toString(),
        style: TextStyle(
          fontSize: maxSize * 0.8,
          height: 1.0,
          color: blocks.hasError(filledField) ? Colors.red : null,
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

    if (!highlightRowsAndColumns) {
      return Colors.transparent;
    }

    if (block == activeBlock) {
      return color.third;
    }

    if (field.absoluteCords.x == activeField.absoluteCords.x) {
      return color.third;
    }

    if (field.absoluteCords.y == activeField.absoluteCords.y) {
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
