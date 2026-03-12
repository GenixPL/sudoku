import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '_models.dart';

abstract class GameModel {
  static final SharedPreferencesAsync _sharedPreferencesAsync = SharedPreferencesAsync();

  static Future<void> removeGame(String id) async {
    await _sharedPreferencesAsync.remove(id);
  }

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

  static Future<Result<Game>> autoFillNotes({
    required Game game,
  }) async {
    final BoardState lastState = game.states.last;
    final List<Field> allFields = lastState.blocks.getAllFields();

    final List<Block> updatedBlocks = [];
    for (Block block in lastState.blocks) {
      final List<Field> updatedFields = [];
      for (Field field in block.fields) {
        switch (field) {
          case EmptyField():
          case NotesField():
            final List<int> options = List.generate(9, (i) => i + 1);

            final List<FilledField> problematicFields = [];
            // For through block and remove options
            problematicFields.addAll(block.fields.whereType());
            // For through column and remove options
            problematicFields.addAll(
              allFields.where((f) => f.absoluteCords.x == field.absoluteCords.x).whereType(),
            );
            // For through row and remove options
            problematicFields.addAll(
              allFields.where((f) => f.absoluteCords.y == field.absoluteCords.y).whereType(),
            );

            for (FilledField problematicField in problematicFields) {
              options.remove(problematicField.number);
            }

            updatedFields.add(
              NotesField(
                numbers: options,
                blockCords: field.blockCords,
                absoluteCords: field.absoluteCords,
              ),
            );
            continue;

          case FilledField():
            updatedFields.add(field);
            continue;
        }
      }
      updatedBlocks.add(
        Block(
          cords: block.cords,
          fields: updatedFields,
        ),
      );
    }

    final Game updatedGame = Game(
      id: game.id,
      states: game.states.toList()
        ..add(
          BoardState(
            blocks: updatedBlocks,
          ),
        ),
    );

    await _saveGame(updatedGame);
    return _getGame(updatedGame.id);
  }

  static Future<Result<Game>> fill({
    required Game game,
    required Block activeBlock,
    required Field activeField,
    required int number,
  }) async {
    // Make the one filled
    final List<Block> updatedBlocks = game.states.last.blocks.toList()
      ..remove(activeBlock)
      ..add(
        activeBlock.withUpdatedFiled(
          switch (activeField) {
            EmptyField() || NotesField() => activeField.filled(number),
            FilledField() => (activeField.number == number) ? activeField.clear() : activeField.filled(number),
          },
        ),
      );

    final List<Block> updatedBlocks2 = [];
    // Update notes
    for (Block block in updatedBlocks) {
      Block updatedBlock = block;
      for (Field field in block.fields) {
        switch (field) {
          case EmptyField():
          case FilledField():
            continue;

          case NotesField():
            final bool isAffected =
                (field.absoluteCords.x == activeField.absoluteCords.x) ||
                (field.absoluteCords.y == activeField.absoluteCords.y) ||
                block == activeBlock;

            if (isAffected) {
              updatedBlock = updatedBlock.withUpdatedFiled(
                NotesField(
                  numbers: field.numbers.toList()..remove(number),
                  blockCords: field.blockCords,
                  absoluteCords: field.absoluteCords,
                ),
              );
            }
        }
      }
      updatedBlocks2.add(updatedBlock);
    }

    final Game updatedGame = Game(
      id: game.id,
      states: game.states.toList()
        ..add(
          BoardState(
            blocks: updatedBlocks2,
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
    } catch (e, stc) {
      await _sharedPreferencesAsync.remove(id);
      print(e);
      print(stc);
      return ErrorResult(
        error: 'failed to parse the game',
      );
    }

    return SuccessResult(
      result: game,
    );
  }
}
