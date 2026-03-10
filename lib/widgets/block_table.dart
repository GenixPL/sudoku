import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class BlockTable extends StatelessWidget {
  const BlockTable({
    super.key,
    required this.onFieldTap,
    required this.activeField,
    required this.activeBlock,
    required this.blocks,
  });

  final OnFieldTap onFieldTap;
  final Field? activeField;
  final Block? activeBlock;
  final List<Block> blocks;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Table(
        border: TableBorder.all(
          color: Colors.black,
          width: 4,
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
                    block: blocks.getByCords(
                      x: x,
                      y: y,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
