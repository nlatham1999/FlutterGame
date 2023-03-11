import 'package:flutter/material.dart';
import 'package:mystic_trails/views/charactercreation.dart';
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
            Consumer<CharacterModel>(builder: (context, characterModel, child){
              return Text("name: ${characterModel.name}");
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var character = context.read<CharacterModel>();
          character.changeName("newName");
        },
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
