

class PlaceModel {
  String name;
  List<String> characters; //list of the names of the characters, each person should have a unique name
  String backgroundImage;
  int gold;

  PlaceModel({
    required this.name,
    required this.characters,
    required this.gold,
    required this.backgroundImage
  });

  void specialAttack(){
    throw UnimplementedError();
  }
}