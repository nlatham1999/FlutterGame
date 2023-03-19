
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';

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
            Text("game start view")
          ],
        ),
      ),
    );
  }
}
