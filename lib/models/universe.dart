//this is the world that the player inhabits 
//so it should be the only state for the game
//all other future states should be for other things

//all functions need to be in here rather than in there respective models to notify the listener

//obviously a consideration here is that it doesn't become too large

import 'package:flutter/foundation.dart';
import 'package:mystic_trails/main.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:mystic_trails/models/knight.dart';
import 'package:mystic_trails/models/skeleton.dart';

class Universe extends ChangeNotifier {

  late CharacterModel mainCharacter;

  //constructor
  Universe({
    required String characterType,
    required String name,
  }) {
    createNewMainCharacter(characterType, name);
  }

  //creates a whole new main character
  void createNewMainCharacter(String characterType, String name){
    switch(characterType){
      case "skeleton":
        mainCharacter = SkeletonModel(name: name);
        break;
      case "knight":
        mainCharacter = Knight(name: name);
        break;
      default: 
        mainCharacter = CharacterModel(name: name, characterType: "none", health: 0, strength: 0);
    }
  }

  //updates the main character type,
  //basically just a wrapper for createNewMainCharacter so I don't have to pass in the name each time
  void updateMainCharacterCharacterType(String characterType){
    print("TESTING" + characterType);
    createNewMainCharacter(characterType, mainCharacter.name);
    print(mainCharacter.characterType);
    notifyListeners();
  }


  //updates the name
  void updateName(String newName){
    mainCharacter.name = newName;
    notifyListeners();
  }

}