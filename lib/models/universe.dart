//this is the world that the player inhabits 
//so it should be the only state for the game
//all other future states should be for other things

//all functions need to be in here rather than in there respective models to notify the listener

//obviously a consideration here is that it doesn't become too large

import 'package:flutter/foundation.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:mystic_trails/models/goblin.dart';
import 'package:mystic_trails/models/knight.dart';
import 'package:mystic_trails/models/place.dart';
import 'package:mystic_trails/models/skeleton.dart';
import 'package:mystic_trails/models/skeletonarcher.dart';

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
      "the whispery cave": PlaceModel(name: "the whispery cave", characters: ["Bones", "Ribsy"], gold: 100),
      "the lone tower": PlaceModel(name: "the lone tower", characters: ["The Dreadful Knight"], gold: 50),
      "the damp hole": PlaceModel(name: "the damp hole", characters: ["Gobbles", "Gibbles"], gold: 50),
    };  
  }

  void createCharacters() {
    characters = {
      'Bones': SkeletonModel(name: "Bones", gold: 10),
      'Ribsy': SkeletonArcherModel(name: "Ribsy", gold: 10),
      'Gobbles': GoblinModel(name: "Gobbles", gold: 10),
      'Gibbles': GoblinModel(name: "Gibbles", gold: 10),
      'The Dreadful Knight': KnightModel(name: "The Dreadful Knight", gold: 10)
    };
  }

  //creates a whole new main character
  void createNewMainCharacter(String characterType, String name){
    switch(characterType){
      case "skeleton":
        mainCharacter = SkeletonModel(name: name, gold: 0);
        break;
      case "knight":
        mainCharacter = KnightModel(name: name, gold: 0);
        break;
      default: 
        mainCharacter = KnightModel(name: name, gold: 0);
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

    String message = "";

    //first the main character fights the highlighted opponent
    message += mainCharacter.attackOpponent(characters[attackFocus]!);
    
    //if the opponent is killed, remove them from the place and pass the gold
    if(characters[attackFocus]!.health == 0){
      attackFocus = "";
    }

    //after the main character attacks then all the other characters in the place attack
    for(String opponent in places[location]!.characters){
      if(characters[opponent] == null){
        return "opponent $opponent not found";
      }
      message += characters[opponent]!.attackOpponent(mainCharacter);
    }

    notifyListeners();

    return message;
  }

  String lootBody(String characterName){
    if(characterName == ""){
      return "loot-ee is not provided";
    }

    if(characters[characterName] == null){
      return "$characterName not found";
    }

    String message = mainCharacter.lootBody(characters[characterName]!);

    notifyListeners();

    return message;
  }

}