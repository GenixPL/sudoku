import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/utils/_utils.dart';
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
  final List<int> _highlights = [];

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
                      highlights: _highlights,
                    ),
                  ),
                ),

                Row(
                  children: [
                    _Button(
                      onTap: onBackTap,
                      child: Transform.scale(
                        scaleX: -1,
                        child: Icon(Icons.redo_rounded),
                      ),
                    ),
                    _Button(
                      onTap: onAutoFill,
                      child: Icon(Icons.app_registration_rounded),
                    ),
                  ].withGaps(8),
                ),

                Keyboard(
                  onTap: (int number) => onKeyboardTap(
                    number: number,
                    activeBlock: activeBlock,
                    activeField: activeField,
                  ),
                ),
                HighlightsKeyboard(
                  onTap: onHighlightTap,
                  active: _highlights,
                ),
              ].withGapsAndPadding(8),
          ],
        ).withHorizontalPadding(8),
      ),
    );
  }

  void onHighlightTap(int number) {
    _highlights.toggle(number);
    setState(() {});
  }

  Future<void> onAutoFill() async {
    final Game? game = _game;
    if (game == null) {
      return;
    }

    final Result<Game> res = await GameModel.autoFillNotes(
      game: game,
    );
    switch (res) {
      case ErrorResult<Game>():
        throw 'error ${res.error}';

      case SuccessResult<Game>():
        _game = res.result;
        setState(() {});
    }
  }

  Future<void> onBackTap() async {
    final Game? game = _game;
    if (game == null) {
      return;
    }

    final Result<Game> res = await GameModel.backState(
      game: game,
    );
    switch (res) {
      case ErrorResult<Game>():
        throw 'error ${res.error}';

      case SuccessResult<Game>():
        _game = res.result;
        setState(() {});
    }
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

class _Button extends StatelessWidget {
  const _Button({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
