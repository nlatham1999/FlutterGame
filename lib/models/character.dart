
class CharacterModel {
  String name;
  String characterType;
  int health;
  int strength;

  CharacterModel({
    required this.name,
    required this.characterType,
    required this.health,
    required this.strength

  });

  void specialAttack(){
    throw UnimplementedError();
  }
}