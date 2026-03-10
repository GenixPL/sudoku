import 'package:sudoku/models/_models.dart';

class Game {
  const Game({
    required this.id,
    required this.states,
  });

  final String id;
  final List<BoardState> states;
}
