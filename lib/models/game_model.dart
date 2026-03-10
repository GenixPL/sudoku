import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '_models.dart';

abstract class GameModel {
  static final SharedPreferencesAsync _sharedPreferencesAsync = SharedPreferencesAsync();

  static Future<Result<Game>> createGame({
    required List<Block> initialBlocks,
  }) async {
    final Game game = Game(
      id: '${Uuid().v4()}_${DateTime.now().toIso8601String()}',
      states: [
        BoardState(
          blocks: initialBlocks,
        ),
      ],
    );

    await _sharedPreferencesAsync.setString(game.id, jsonEncode(game));

    return SuccessResult(
      result: game,
    );
  }

  static Future<Result<List<String>>> getAllGames() async {
    final Set<String> ids = await _sharedPreferencesAsync.getKeys();

    return SuccessResult(
      result: ids.toList(),
    );
  }

  static Future<Result<Game>> getGame(String id) async {
    final String? gameString = await _sharedPreferencesAsync.getString(id);
    if (gameString == null) {
      return ErrorResult(
        error: 'no game with given id ($id)',
      );
    }

    return SuccessResult(
      result: Game.fromJson(jsonDecode(gameString)),
    );
  }

  static Future<Result<Game>> backState({
    required Game game,
  }) async {
    return ErrorResult(
      error: 'not implemented',
    );
  }

  static Future<Result<Game>> fillNotes({
    required Game game,
  }) async {
    return ErrorResult(
      error: 'not implemented',
    );
  }

  static Future<Result<Game>> fill({
    required Game game,
  }) async {
    return ErrorResult(
      error: 'not implemented',
    );
  }
}
