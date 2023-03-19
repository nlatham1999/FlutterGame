
import 'package:mystic_trails/models/character.dart';

class Knight extends CharacterModel {
  
  Knight({
    required String name
  }): super (
    name: name,
    characterType: "knight",
    health: 90,
    strength: 70
  );

  @override
  void specialAttack(){

  }
}