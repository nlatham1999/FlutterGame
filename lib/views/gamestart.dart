
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/place.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:mystic_trails/views/dungeon.dart';
import 'package:provider/provider.dart';

class GameStart extends StatefulWidget {
  const GameStart({super.key, required this.title});

  final String title;

  @override
  State<GameStart> createState() => _GameStart();
}

class _GameStart extends State<GameStart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Universe>(builder: (context, universe, child){
              return Column(
                children: [
                  for(String placeName in universe.places.keys)
                    TextButton(
                      onPressed: () {
                        String text = placeName;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dungeon(title: text,)),
                        );
                      }, 
                      child: Text("enter ${placeName}")
                    ),
                ],
              );
              // return Text("name: ${universe.mainCharacter.name}");
            },),
          ],
        ),
      ),
      bottomSheet: Consumer<Universe>(builder: (context, universe, child){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("name: ${universe.mainCharacter.name}"),
            Text("type: ${universe.mainCharacter.characterType}"),
            Text("health: ${universe.mainCharacter.health}/${universe.mainCharacter.maxHealth}"),
            Text("gold: ${universe.mainCharacter.gold}"),
        ],);
      },),
    );
  }
}
