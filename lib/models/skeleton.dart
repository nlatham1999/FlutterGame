
import 'package:mystic_trails/models/character.dart';

class SkeletonModel extends CharacterModel {
  
  SkeletonModel({
    required String name,
    required int gold,
  }): super (
    name: name,
    characterType: "skeleton",
    health: 60,
    attack: 10,
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