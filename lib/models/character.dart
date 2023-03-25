
class CharacterModel {
  String name;
  String characterType;
  int health;
  late int maxHealth;
  int attack;

  CharacterModel({
    required this.name,
    required this.characterType,
    required this.health,
    required this.attack,
  }){
    maxHealth = health;
  }

  
  //attacks opponent and returns the opponent
  attackOpponent(CharacterModel opponent){
    throw UnimplementedError();
  }

  void specialAttack(){
    throw UnimplementedError();
  }
}