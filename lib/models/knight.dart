
import 'package:mystic_trails/models/character.dart';

class KnightModel extends CharacterModel {
  
  KnightModel({
    required String name
  }): super (
    name: name,
    characterType: "knight",
    health: 90,
    attack: 7
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