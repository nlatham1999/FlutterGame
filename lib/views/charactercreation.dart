
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

  @override
  void initState() {
    super.initState();
    var universe = context.read<Universe>();
    _playerName = universe.mainCharacter.name;
    _playerCharacterType = universe.mainCharacter.characterType;
    _selectedValue = _playerCharacterType;
  }
  
  void updateName(String newName){
    setState(() {
      _playerName = newName;
    });
  }

  void updateCharacterType(String newCharacterType){
    setState(() {
      _playerCharacterType = newCharacterType;
    });
  }

  void saveChanges(){
    var universe = context.read<Universe>();
    universe.updateName(_playerName);
    universe.updateMainCharacterCharacterType(_playerCharacterType);
    Navigator.pop(context);
  }

  String _playerName = "nil";
  String _playerCharacterType = "knight";

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

  late String _selectedValue;
  ElevatedButton dropdownPopup(String buttonText, String title, void Function(String) onOkPressed ){
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: DropdownButtonFormField(
                hint: const Text('Select a character type'),
                value: _selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue = newValue as String;
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
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onOkPressed(_selectedValue);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
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
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onOkPressed(textController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
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
            const Text("when you are done editing your character click on 'Save Changes'"),
            
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text("name: $_playerName"),
                textPopup("Change Name", "Change Name", updateName),
            ],),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              Text("character type: $_playerCharacterType"),
              dropdownPopup("Change character type", "Select character type", updateCharacterType),
            ],),

            TextButton(
              onPressed: (){
                saveChanges();
              }, 
              child: const Text("Save Changes")
            ),
          ],
        ),
      ),
    );
  }
}
