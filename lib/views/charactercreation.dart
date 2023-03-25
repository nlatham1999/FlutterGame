
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

  void updateCharacterType(){
    var universe = context.read<Universe>();
    universe.updateMainCharacterCharacterType(_selectedItem);
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
  ];

  DropdownButton dropdown(void Function() onSelected){ //List<String> itemList, void Function(String) onSelected){
     return DropdownButton(
      hint: Text('Select an item'),
      value: _selectedItem,
      onChanged: (newValue) {
        setState(() {
          _selectedItem = newValue;
        });
        onSelected();
      },
      items: _characterTypes.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  ElevatedButton dropdownPopup(String buttonText, String title, String initialValue, void Function() onOkPressed ){
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: DropdownButton(
                hint: Text('Select an item'),
                value: initialValue,
                onChanged: (newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                items: _characterTypes.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
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
                    onOkPressed();
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
            const Text("when you are done editing your character press the back button"),
            
            Consumer<Universe>(builder: (context, universe, child){
              return Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Text("name: ${universe.mainCharacter.name}"),
                  textPopup("Change Name", "Change Name", updateName),
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  Text("character type: ${universe.mainCharacter.characterType}"),
                  dropdownPopup("Change character type", "Select character type", universe.mainCharacter.characterType, updateCharacterType),
                ],),
              ],);
            },),
          ],
        ),
      ),
    );
  }
}
