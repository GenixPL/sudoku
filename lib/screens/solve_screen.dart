import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/utils/_utils.dart';
import 'package:sudoku/utils/widget_list_extensions.dart';
import 'package:sudoku/widgets/_widgets.dart';

class SolveScreen extends StatefulWidget {
  const SolveScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<SolveScreen> createState() => _SolveScreenState();
}

class _SolveScreenState extends State<SolveScreen> {
  Game? _game;

  Cords? _activeFieldCords;
  Cords? _activeBlockCords;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final List<Block>? blocks = _game?.states.last.blocks;
    final Block? activeBlock = blocks?.tryGetByBlockCords(_activeBlockCords);
    final Field? activeField = activeBlock?.fields.tryGetByCords(_activeFieldCords);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id.split('_').last),
      ),
      body: Center(
        child: Column(
          children: [
            if (blocks == null)
              CircularProgressIndicator()
            else
              ...[
                Expanded(
                  child: Center(
                    child: BlockTable(
                      onFieldTap: onFieldTap,
                      activeField: activeField,
                      activeBlock: activeBlock,
                      highlightRowsAndColumns: true,
                      blocks: blocks,
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
          ],
        ).withHorizontalPadding(8),
      ),
    );
  }

  void onFieldTap(Block block, Field field) {
    if (block.cords == _activeBlockCords && field.blockCords == _activeFieldCords) {
      _activeFieldCords = null;
      _activeBlockCords = null;
      setState(() {});
      return;
    }

    _activeFieldCords = field.blockCords;
    _activeBlockCords = block.cords;
    setState(() {});
  }

  Future<void> onKeyboardTap({
    required int number,
    required Block? activeBlock,
    required Field? activeField,
  }) async {
    final Game? game = _game;
    if (game == null || activeBlock == null || activeField == null) {
      return;
    }

    final Result<Game> res = await GameModel.fill(
      game: game,
      activeBlock: activeBlock,
      activeField: activeField,
      number: number,
    );
    switch (res) {
      case SuccessResult<Game>():
        _game = res.result;
        setState(() {});
        return;

      case ErrorResult<Game>():
        throw 'error ${res.error}';
    }
  }

  Future<void> _init() async {
    final Result<Game> res = await GameModel.getGame(widget.id);
    switch (res) {
      case ErrorResult<Game>():
        throw 'error ${res.error}';

      case SuccessResult<Game>():
        _game = res.result;
        setState(() {});
    }
  }
}
