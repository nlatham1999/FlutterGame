
class CharacterModel {
  String name;
  String characterType;
  int health;
  late int maxHealth;
  int attack;
  int gold;
  bool looted = false;

  CharacterModel({
    required this.name,
    required this.characterType,
    required this.health,
    required this.attack,
    required this.gold,
  }){
    maxHealth = health;
  }
  
  //attacks opponent and returns the opponent
  String attackOpponent(CharacterModel opponent){
    return "";
  }

  void specialAttack(){
    throw UnimplementedError();
  }

  //loots the character being passed in
  String lootBody(CharacterModel character){
    int goldAmount = character.gold;
    
    character.gold = 0;

    this.gold += goldAmount;

    character.looted = true;

    return "looted $goldAmount gold";
  }
}