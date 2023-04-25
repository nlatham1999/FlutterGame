
import 'package:flutter/material.dart';
import 'package:mystic_trails/models/place.dart';
import 'package:mystic_trails/models/universe.dart';
import 'package:mystic_trails/views/dungeon.dart';
import 'package:mystic_trails/views/styles/main_styles.dart';
import 'package:mystic_trails/views/view_utils/util.dart';
import 'package:provider/provider.dart';

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
      appBar: ViewUtils.topAppBar(widget.title, context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_page_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Universe>(builder: (context, universe, child){
              return Column(
                children: [

                  for(String placeName in universe.places.keys)

                    Container(
                      width: MediaQuery.of(context).size.width * MainStyles.buttonWidthPercentage(),
                      margin: const EdgeInsets.all(5.0),
                      decoration: MainStyles.mainButtonStyle(),
                      child: TextButton(
                        onPressed: () {
                          String text = placeName;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Dungeon(title: text, backgroundImage: universe.places[placeName]!.backgroundImage,)),
                          );
                        }, 
                        child: Text("enter $placeName", style: MainStyles.buttonTextStyle(),)
                      ),
                    ),
                ],
              );
              // return Text("name: ${universe.mainCharacter.name}");
            },),
          ],
        ),
      ),
    );
  }
}
