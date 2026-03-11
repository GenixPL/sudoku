import 'package:flutter/material.dart';
import 'package:sudoku/models/_models.dart';
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

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final Game? game = _game;

    return Scaffold(
      body: ExpandedSingleChildScrollView(
        child: Column(
          children: [
            if (game == null) CircularProgressIndicator() else Text('solve'),
          ],
        ),
      ),
    );
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
