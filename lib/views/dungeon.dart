// this is the view for when a player goes into a location


import 'package:flutter/material.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:mystic_trails/views/styles/main_styles.dart';
import 'package:mystic_trails/views/view_utils/util.dart';
import 'package:provider/provider.dart';

import '../models/universe.dart';

class Dungeon extends StatefulWidget {
  Dungeon({super.key, required this.title, required this.backgroundImage});

  String title;
  String backgroundImage;

  @override
  State<Dungeon> createState() => _Dungeon();
}

class _Dungeon extends State<Dungeon> {

  void updateAttackFocus(String attackFocus){
    var universe = context.read<Universe>();
    universe.updateAttackFocus(attackFocus);
  }

  void leavePlace(){
    var universe = context.read<Universe>();
    universe.updateAttackFocus("");
  }

  void doFight(){
    var universe = context.read<Universe>();
    String output = universe.fightAtPlace(widget.title);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return afterFightPopup(output);
      }
  );
  }

  void lootBody(String opponentName){
    var universe = context.read<Universe>();
    String output = universe.lootBody(opponentName);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return afterFightPopup(output);
        }
    );
  }
  
  AlertDialog afterFightPopup(String message){
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Ok"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {   
    return WillPopScope(onWillPop: () async {leavePlace(); return true;},
    child: Scaffold(
      appBar: ViewUtils.topAppBar(widget.title, context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Text("you are in the ${widget.title}, ${widget.backgroundImage}"),
            Consumer<Universe>(builder: (context, universe, child){
              return (
                Column(
                  children: [
                    Text("attack focus: ${universe.attackFocus} "),
                    const Text("Opponents:"),
                    for (String opponent in universe.places[widget.title]!.characters) 
                      Column(children: [
                        Text("name: $opponent"),
                        Text("type: ${universe.characters[opponent]!.characterType}"),
                        Text("health: ${universe.characters[opponent]!.health}"),
                        Text("attack: ${universe.characters[opponent]!.attack}"),
                        if(universe.characters[opponent]!.health > 0)
                          TextButton(onPressed: () {updateAttackFocus(opponent);}, child: Text("focus attack on $opponent!"),)
                        else if (!universe.characters[opponent]!.looted)
                          TextButton(onPressed: () {lootBody(opponent);}, child: const Text("loot body"))
                      ]),
                    TextButton(onPressed: (){doFight();}, child: const Text("Fight!"),)
                  ],
                )
              );
            },),
              
          ],
        ),
      ),
      bottomSheet: Theme( 
        data: MainStyles.bottomSheetStyle(),
        child: Consumer<Universe>(builder: (context, universe, child){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("name: ${universe.mainCharacter.name}"),
              Text("type: ${universe.mainCharacter.characterType}"),
              Text("health: ${universe.mainCharacter.health}/${universe.mainCharacter.maxHealth}"),
              Text("gold: ${universe.mainCharacter.gold}"),
            ],
          );
        },),
      ),
    ));
  }
}
