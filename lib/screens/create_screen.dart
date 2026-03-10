import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/utils/_utils.dart';
import 'package:sudoku/widgets/_widgets.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({
    super.key,
  });

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final List<Block> _blocks = Block.createList();

  Field? _activeField;
  Block? _activeBlock;

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
              child: Center(
                child: BlockTable(
                  onFieldTap: onFieldTap,
                  activeField: _activeField,
                  activeBlock: _activeBlock,
                  blocks: _blocks,
                ),
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
  
  void onFieldTap(Block block, Field field) {
    if (block == _activeBlock && field == _activeField) {
      _activeField = null;
      _activeBlock = null;
      setState(() {});
      return;
    }

    _activeField = field;
    _activeBlock = block;
    setState(() {});
  }
}
