// this is the view for when a player goes into a location


import 'package:flutter/material.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:provider/provider.dart';

import '../models/universe.dart';

class Dungeon extends StatefulWidget {
  Dungeon({super.key, required this.title});

  String title;

  @override
  State<Dungeon> createState() => _Dungeon();
}

class _Dungeon extends State<Dungeon> {

  void updateAttackFocus(String attackFocus){
    var universe = context.read<Universe>();
    universe.updateAttackFocus(attackFocus);
  }

  void doFight(){
    var universe = context.read<Universe>();
    String output = universe.fightAtPlace(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("you are in the ${widget.title}"),
            Consumer<Universe>(builder: (context, universe, child){
              return (
                Column(
                  children: [
                    Text("attack focus: ${universe.attackFocus} "),
                    Text("Opponents:"),
                    for (String opponent in universe.places[widget.title]!.characters) 
                      Column(children: [
                        Text("name: $opponent"),
                        Text("type: ${universe.characters[opponent]!.characterType}"),
                        Text("health: ${universe.characters[opponent]!.health}"),
                        Text("attack: ${universe.characters[opponent]!.attack}"),
                        MaterialButton(onPressed: () {updateAttackFocus(opponent);}, child: Text("focus attack on $opponent!"),)
                      ]),
                    Container(child: Column(children: [
                      Text("${universe.mainCharacter.name}"),
                      Text("${universe.mainCharacter.health}"),
                      Text("${universe.mainCharacter.attack}"),
                    ]),),
                    MaterialButton(onPressed: (){doFight();}, child: const Text("Fight!"),)
                  ],
                )
              );
            },),
          ],
        ),
      ),
    );
  }
}
