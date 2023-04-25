import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/universe.dart';

class ViewUtils {
  static AppBar topAppBar(String title, BuildContext context){
    return AppBar(
      title: Text(title),
      actions: [
        
        Ink(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/money-bag.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
              // optional border radius
          ),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.bottomCenter,
              child: Consumer<Universe>(
                builder: (context, universe, child){
                  return Text("${universe.mainCharacter.gold}");
                }
              ),
            ),
          ),
        ),
        Ink(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/knight_1.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
              // optional border radius
          ),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) { 
                  return Consumer<Universe>(
                    builder: (context, universe, child){
                      return AlertDialog(
                        title: Text("${universe.mainCharacter.name} - ${universe.mainCharacter.characterType} "),
                        content: Column(
                          children: [
                            Row(children: [
                              const Text("health: "),
                              Text("${universe.mainCharacter.health}/${universe.mainCharacter.maxHealth}")
                            ],),
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("ok"))
                        ],
                      );
                    }
                  );
                }
              );
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}