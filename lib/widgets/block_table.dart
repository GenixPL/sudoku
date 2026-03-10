import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class BlockTable extends StatelessWidget {
  const BlockTable({
    super.key,
    required this.blocks,
  });

  final List<Block> blocks;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: AspectRatio(
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
                      block: blocks.getByCords(
                        x: x,
                        y: y,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
