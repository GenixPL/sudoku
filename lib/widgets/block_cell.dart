import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class BlockCell extends StatelessWidget {
  const BlockCell({
    super.key,
    required this.block,
  });

  final Block block;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: Colors.amber,
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
                      field: block.fields.getByCords(
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
