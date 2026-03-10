import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/widgets/_widgets.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  List<String>? _games;

  @override
  void initState()  {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final List<String>? games = _games;

    return Scaffold(
      appBar: AppBar(
        title: Text('game list'),
      ),
      body: SafeArea(
        child: ExpandedSingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                if (games == null)
                  CircularProgressIndicator()
                else
                  for (String game in games)
                    TextButton(
                      onPressed: () => context.go('/solve/$game'),
                      child: Text(game.split('_').last),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _init() async {
    final Result<List<String>> res = await GameModel.getAllGames();
    switch (res) {
      case SuccessResult<List<String>>():
        _games = res.result;
        setState(() {});

      case ErrorResult<List<String>>():
        throw 'error: ${res.error}';
    }
  }
}
