
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';

class CharacterCreation extends StatefulWidget {
  const CharacterCreation({super.key, required this.title});

  final String title;

  @override
  State<CharacterCreation> createState() => _CharacterCreation();
}

class _CharacterCreation extends State<CharacterCreation> {

  

  void updateName(String newName){
    var universe = context.read<Universe>();
    universe.updateName(newName);
  }

  ElevatedButton textPopup(String buttonText, String title, void Function(String) onOkPressed ){
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController textController = TextEditingController();
            return AlertDialog(
              title: Text(title),
              content: TextField(
                autocorrect: true,
                controller: textController, 
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onOkPressed(textController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                ),
              ],
            );
          },
        );
      },
      child: Text(buttonText),
    );
  }



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
            textPopup("Change Name", "Change Name", updateName),
            Consumer<Universe>(builder: (context, characterModel, child){
              return Text("name: ${characterModel.mainCharacter.name}");
            },),
            TextButton(
              onPressed: (){

              }, 
              child: const Text("create new character")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
