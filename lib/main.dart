import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/character.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:mystic_trails/util/util.dart';
import 'package:mystic_trails/views/mainpage.dart';
import 'package:mystic_trails/views/styles/main_styles.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      create: (context) => Universe(
        characterType: "",
        name: "nil", 
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
        primarySwatch: MainStyles.mainBackgroundColor()
      ),
      home: const MyHomePage(title: 'Mystic Trails'),
    );
  }
}

