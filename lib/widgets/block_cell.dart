import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class BlockCell extends StatelessWidget {
  const BlockCell({
    super.key,
    required this.onFieldTap,
    required this.activeField,
    required this.activeBlock,
    required this.blocks,
    required this.highlightRowsAndColumns,
    required this.block,
  });

  final OnFieldTap onFieldTap;
  final Field? activeField;
  final Block? activeBlock;
  final List<Block> blocks;
  final bool highlightRowsAndColumns;
  final Block block;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 2,
        ),
        children: [
          for (int y = 0; y < 3; y++)
            TableRow(
              children: [
                for (int x = 0; x < 3; x++)
                  FieldCell(
                    onFieldTap: onFieldTap,
                    activeField: activeField,
                    activeBlock: activeBlock,
                    highlightRowsAndColumns: highlightRowsAndColumns,
                    blocks: blocks,
                    block: block,
                    field: block.fields.getByCords(Cords.xy(x, y)),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
