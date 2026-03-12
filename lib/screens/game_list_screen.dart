import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/models/_models.dart';
import 'package:sudoku/utils/widget_list_extensions.dart';
import 'package:sudoku/widgets/_widgets.dart';

// TODO(genix): remove notes when filling
// TODO(genix): add highlights
// TODO(genix): add editing notes
class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  List<String>? _games;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final List<String>? games = _games;

    return Scaffold(
      appBar: AppBar(
        title: Text('gameId list'),
      ),
      body: SafeArea(
        child: ExpandedSingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                if (games == null)
                  CircularProgressIndicator()
                else
                  for (String gameId in games)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => context.go('/solve/$gameId'),
                          child: Text(gameId.split('_').last),
                        ),
                        IconButton(
                          onPressed: () => _remove(gameId),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ].withGaps(8),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _remove(String id) async {
    await GameModel.removeGame(id);
    await _load();
  }

  Future<void> _load() async {
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
