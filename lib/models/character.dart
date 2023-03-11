
import 'package:flutter/material.dart';

class CharacterModel extends ChangeNotifier {
  String name;
  int health;
  int strength;

  CharacterModel({
    required this.name,
    required this.health,
    required this.strength
  });

  void changeName(String newName){
    name = newName;
    notifyListeners();
  }
}