
import 'package:mystic_trails/models/character.dart';

class SkeletonModel extends CharacterModel {
  
  SkeletonModel({
    required String name
  }): super (
    name: name,
    characterType: "skeleton",
    health: 50,
    strength: 50
  );

  @override
  void specialAttack(){

  }
}