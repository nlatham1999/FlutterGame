
import 'package:mystic_trails/models/character.dart';

class KnightModel extends CharacterModel {
  
  KnightModel({
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