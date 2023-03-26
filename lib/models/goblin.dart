
import 'package:mystic_trails/models/character.dart';

class GoblinModel extends CharacterModel {
  
  GoblinModel({
    required String name,
    required int gold,
  }): super (
    name: name,
    characterType: "goblin",
    health: 20,
    attack: 5,
    gold: gold,
  );

  @override
  void specialAttack(){

  }

  @override
  String attackOpponent(CharacterModel opponent){
    int attackAmount = this.attack;
    opponent.health -= attackAmount;

    String message = "⚔ ${this.name} dealt $attackAmount damage to ${opponent.name} \n";

    if (opponent.health < 0) {
      opponent.health = 0;
      message += "💀 ${this.name} killed ${opponent.name}!";
    }

    return message;
  }
}