import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:mystic_trails/views/mainpage.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      create: (context) => CharacterModel(
        name: "nil", 
        health: 0,
        strength: 0,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystic Trails',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Mystic Trails'),
    );
  }
}

