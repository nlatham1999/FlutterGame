

class PlaceModel {
  String name;
  List<String> characters; //list of the names of the characters, each person should have a unique name

  int gold;

  PlaceModel({
    required this.name,
    required this.characters,
    required this.gold
  });

  void specialAttack(){
    throw UnimplementedError();
  }
}