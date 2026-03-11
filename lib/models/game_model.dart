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

    await _saveGame(game);

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

  static Future<Result<Game>> getGame(String id) {
    return _getGame(id);
  }

  static Future<Result<Game>> backState({
    required Game game,
  }) async {
    if (game.states.length <= 1) {
      return ErrorResult(
        error: 'no states to pop',
      );
    }

    final Game updatedGame = Game(
      id: game.id,
      states: game.states.toList()..removeLast(),
    );

    await _saveGame(updatedGame);

    return _getGame(game.id);
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
    required Block activeBlock,
    required Field activeField,
    required int number,
  }) async {
    final Game updatedGame = Game(
      id: game.id,
      states: game.states.toList()
        ..add(
          BoardState(
            blocks: game.states.last.blocks.toList()
              ..remove(activeBlock)
              ..add(
                activeBlock.withUpdatedFiled(
                  switch (activeField) {
                    EmptyField() || NotesField() => activeField.filled(number),
                    FilledField() => (activeField.number == number) ? activeField.clear() : activeField.filled(number),
                  },
                ),
              ),
          ),
        ),
    );

    await _saveGame(updatedGame);

    return _getGame(updatedGame.id);
  }

  static Future<void> _saveGame(Game game) async {
    await _sharedPreferencesAsync.setString(game.id, jsonEncode(game));
  }

  static Future<Result<Game>> _getGame(String id) async {
    final String? gameString = await _sharedPreferencesAsync.getString(id);
    if (gameString == null) {
      return ErrorResult(
        error: 'no game with given id ($id)',
      );
    }

    final Game game;
    try {
      game = Game.fromJson(jsonDecode(gameString));
    } catch (e) {
      await _sharedPreferencesAsync.remove(id);
      return ErrorResult(
        error: 'failed to parse the game',
      );
    }

    return SuccessResult(
      result: game,
    );
  }
}
