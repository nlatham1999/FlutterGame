//this is the world that the player inhabits 
//so it should be the only state for the game
//all other future states should be for other things

//all functions need to be in here rather than in there respective models to notify the listener

import 'package:flutter/foundation.dart';
import 'package:mystic_trails/models/character.dart';

class Universe extends ChangeNotifier {

  late CharacterModel mainCharacter;

  Universe({
    required String name,
    required int health,
    required int strength,
  }) {
    mainCharacter = CharacterModel(
      name: name,
      health: health,
      strength: strength,
    );
  }

  void updateName(String newName){
    mainCharacter.name = newName;
    notifyListeners();
  }

}