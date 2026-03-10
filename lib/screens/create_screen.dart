import 'package:flutter/material.dart';
import 'package:sudoku/utils/_utils.dart';
import 'package:sudoku/widgets/_widgets.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
            Keyboard(
              onTap: print,
            ),
          ].withGapsAndPadding(8),
        ).withHorizontalPadding(8),
      ),
    );
  }
}
