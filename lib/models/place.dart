
class PlaceModel {
  String name;
  List<String> characters; //list of the names of the characters, each person should have a unique name

  PlaceModel({
    required this.name,
    required this.characters
  });

  void specialAttack(){
    throw UnimplementedError();
  }
}