
import 'package:mystic_trails/models/character.dart';

class SkeletonModel extends CharacterModel {
  
  SkeletonModel({
    required String name
  }): super (
    name: name,
    characterType: "skeleton",
    health: 60,
    attack: 10
  );

  @override
  void specialAttack(){

  }

  @override
  attackOpponent(CharacterModel opponent){
    opponent.health = opponent.health - this.attack;

    if (opponent.health < 0) {
      opponent.health = 0;
    }
  }
}