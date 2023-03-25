//this is the world that the player inhabits 
//so it should be the only state for the game
//all other future states should be for other things

//all functions need to be in here rather than in there respective models to notify the listener

//obviously a consideration here is that it doesn't become too large

import 'package:flutter/foundation.dart';
import 'package:mystic_trails/main.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:mystic_trails/models/knight.dart';
import 'package:mystic_trails/models/place.dart';
import 'package:mystic_trails/models/skeleton.dart';

class Universe extends ChangeNotifier {

  bool mainCharacterInitialized = false;
  late CharacterModel mainCharacter;
  Map<String, CharacterModel> characters = {};
  Map<String, PlaceModel> places = {};

  String attackFocus = "";

  //constructor
  Universe({
    required String characterType,
    required String name,
  }) {
    createNewMainCharacter(characterType, name);
    createCharacters();
    createPlaces();
  }

  void createPlaces() {
    places = {
      "the whispery cave": PlaceModel(name: "the whispery cave", characters: ["Bones"]),
    };  
  }

  void createCharacters() {
    characters = {
      'Bones': SkeletonModel(name: "Bones"),
      'The Dreadful Knight': KnightModel(name: "The Dreadful Knight")
    };
  }

  //creates a whole new main character
  void createNewMainCharacter(String characterType, String name){
    switch(characterType){
      case "skeleton":
        mainCharacter = SkeletonModel(name: name);
        break;
      case "knight":
        mainCharacter = KnightModel(name: name);
        break;
      default: 
        mainCharacter = KnightModel(name: name);
    }
  }

  //updates the main character type,
  //basically just a wrapper for createNewMainCharacter so I don't have to pass in the name each time
  void updateMainCharacterCharacterType(String characterType){
    mainCharacterInitialized = true;
    createNewMainCharacter(characterType, mainCharacter.name);
    notifyListeners();
  }


  //updates the name
  void updateName(String newName){
    mainCharacter.name = newName;
    notifyListeners();
  }

  void updateAttackFocus(String attackFocus){
    this.attackFocus = attackFocus;
    notifyListeners();
  }  

  String fightAtPlace(String location){

    if (location == ""){
      return "You cannot select an empty location";
    }

    if (places[location] == null){
      return "location $location not found";
    }

    if (attackFocus == "") {
      return "You need to select an opponent to focus your attack";
    }

    if (characters[attackFocus] == null) {
      return "character $attackFocus not found";
    }

    print(characters[attackFocus]!.health);

    //first the main character fights the highlighted opponent
    mainCharacter.attackOpponent(characters[attackFocus]!);

    
    print(characters[attackFocus]!.health);

    //after the main character attacks then all the other characters in the place attack
    for(String opponent in places[location]!.characters){
      if(characters[opponent] == null){
        return "opponent $opponent not found";
      }
      characters[opponent]!.attackOpponent(mainCharacter);
    }

    notifyListeners();

    return "";
  }

}