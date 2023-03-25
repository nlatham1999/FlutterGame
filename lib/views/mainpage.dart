import 'package:flutter/material.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:mystic_trails/views/charactercreation.dart';
import 'package:mystic_trails/views/gamestart.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                children: <Widget>[
                  if (!universe.mainCharacterInitialized) Text("Main character not created yet \nClick on 'create new character'"),
                  TextButton(
                    onPressed: universe.mainCharacterInitialized ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GameStart(title: "main game",)),
                      );
                    } : null,
                    child: const Text("Begin your journey"),
                  ),
                ],
              );
              // return Text("name: ${universe.mainCharacter.name}");
            },),
            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CharacterCreation(title: "character creation",)),
                );
              }, 
              child: const Text("create new character")
            ),
          ],
        ),
      ),
      bottomSheet: Consumer<Universe>(builder: (context, universe, child){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("name: ${universe.mainCharacter.name}"),
            Text("type: ${universe.mainCharacter.characterType}"),
            Text("health: ${universe.mainCharacter.health}/${universe.mainCharacter.maxHealth}")
        ],);
      },),
    );
  }
}
