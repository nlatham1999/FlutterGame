
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:mystic_trails/views/styles/main_styles.dart';
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

  final Map<String, String> _characterTypesToImage = {
    'skeleton': "assets/shield.png",
    'knight': "assets/knight.png",
  };

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/armory.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: Text("when you are done editing your character click on 'Save Changes'", style: MainStyles.buttonTextStyle(),),
            ),

            Container(
              margin:  const EdgeInsets.only(top: 40.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Text("name: $_playerName", style: MainStyles.buttonTextStyle(),),
                  textPopup("Change Name", "Change Name", updateName),
              ],),
            ),

            Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_characterTypesToImage[_playerCharacterType]!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                Text("character type: $_playerCharacterType", style: MainStyles.buttonTextStyle(),),
                dropdownPopup("Change character type", "Select character type", updateCharacterType),
              ],),
            ),

            ElevatedButton(
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
