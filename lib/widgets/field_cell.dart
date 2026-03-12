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
          child: switch (field) {
            EmptyField() => const SizedBox(),
            NotesField() => _buildNotes(field),
            FilledField() => _buildFilled(
              filledField: field,
            ),
          },
        ),
      ),
    );
  }

  Widget _buildNotes(NotesField notesField) {
    return Table(
      children: [
        for (int i = 0; i < 3; i++)
          TableRow(
            children: [
              for (int j = 1; j <= 3; j++)
                AspectRatio(
                  aspectRatio: 1,
                  child: notesField.numbers.contains(i * 3 + j)
                      ? _buildNumber(
                          number: i * 3 + j,
                        )
                      : const SizedBox(),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildFilled({
    required FilledField filledField,
  }) {
    return _buildNumber(
      number: filledField.number,
      hasError: blocks.hasError(filledField),
    );
  }

  Widget _buildNumber({
    required int number,
    bool hasError = false,
  }) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: constraints.maxHeight * 0.8,
              height: 1.0,
              color: hasError ? Colors.red : null,
            ),
          ),
        );
      },
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
