import 'package:uuid/uuid.dart';

import '_models.dart';

class GameModel {
  Future<Result<Game>> createGame({
    required List<Block> initialBlocks,
  }) async {
    return SuccessResult(
      result: Game(
        id: Uuid().v4(),
        states: [
          BoardState(
            blocks: initialBlocks,
          ),
        ],
      ),
    );
  }

  Future<Result<Game>> backState({
    required Game game,
  }) async {
    return ErrorResult(
      error: 'not implemented',
    );
  }

  Future<Result<Game>> fillNotes({
    required Game game,
  }) async {
    return ErrorResult(
      error: 'not implemented',
    );
  }

  Future<Result<Game>> fill({
    required Game game,
  }) async {
    return ErrorResult(
      error: 'not implemented',
    );
  }
}
