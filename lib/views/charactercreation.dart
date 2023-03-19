
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

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedItem = _items.first;
  // }
  
  void updateName(String newName){
    var universe = context.read<Universe>();
    universe.updateName(newName);
  }

  void updateCharacterType(String newType){
    var universe = context.read<Universe>();
    universe.updateMainCharacterCharacterType(newType);
  }

  String _selectedItem = 'skeleton';

  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final List<String> _characterTypes = [
    'skeleton',
    'knight',
    'test'
  ];

  DropdownButton dropdown(void Function(String) onSelected){ //List<String> itemList, void Function(String) onSelected){
     return DropdownButton(
      hint: Text('Select an item'),
      value: _selectedItem,
      onChanged: (newValue) {
        setState(() {
          _selectedItem = newValue;
        });
        onSelected(newValue);
      },
      items: _characterTypes.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
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
            dropdown(updateCharacterType),
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
