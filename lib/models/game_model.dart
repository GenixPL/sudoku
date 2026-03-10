import '_models.dart';

class GameModel {
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
