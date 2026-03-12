import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class BlockTable extends StatelessWidget {
  const BlockTable({
    super.key,
    required this.onFieldTap,
    required this.activeField,
    required this.activeBlock,
    required this.highlightRowsAndColumns,
    required this.blocks,
    required this.highlights,
  });

  final OnFieldTap onFieldTap;
  final Field? activeField;
  final Block? activeBlock;
  final bool highlightRowsAndColumns;
  final List<Block> blocks;
  final List<int> highlights;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 3,
        ),
        children: [
          for (int y = 0; y < 3; y++)
            TableRow(
              children: [
                for (int x = 0; x < 3; x++)
                  BlockCell(
                    onFieldTap: onFieldTap,
                    activeBlock: activeBlock,
                    activeField: activeField,
                    highlightRowsAndColumns:highlightRowsAndColumns,
                    blocks: blocks,
                    block: blocks.getByBlockCords(Cords.xy(x, y)),
                      highlights:highlights,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
