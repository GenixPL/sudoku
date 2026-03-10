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

  Cords? _activeFieldCords;
  Cords? _activeBlockCords;

  @override
  Widget build(BuildContext context) {
    final Block? activeBlock = _blocks.tryGetByCords(_activeBlockCords);
    final Field? activeField = activeBlock?.fields.tryGetByCords(_activeFieldCords);

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
                  activeField: activeField,
                  activeBlock: activeBlock,
                  blocks: _blocks,
                ),
              ),
            ),
            Keyboard(
              onTap: (int number) => onKeyboardTap(
                number: number,
                activeBlock: activeBlock,
                activeField: activeField,
              ),
            ),
          ].withGapsAndPadding(8),
        ).withHorizontalPadding(8),
      ),
    );
  }

  void onKeyboardTap({
    required int number,
    required Block? activeBlock,
    required Field? activeField,
  }) {
    if (activeField == null || activeBlock == null) {
      return;
    }

    _blocks
      ..remove(activeBlock)
      ..add(activeBlock.withUpdatedFiled(activeField.filled(number)));

    setState(() {});
  }

  void onFieldTap(Block block, Field field) {
    if (block.cords == _activeBlockCords && field.cords == _activeFieldCords) {
      _activeFieldCords = null;
      _activeBlockCords = null;
      setState(() {});
      return;
    }

    _activeFieldCords = field.cords;
    _activeBlockCords = block.cords;
    setState(() {});
  }
}
