import 'package:flutter/material.dart';

import '../../util/util.dart';

class MainStyles {

  static MaterialColor mainBackgroundColor() {
    return materialColorFromRGB(38, 66, 5);
  }

  static ThemeData bottomSheetStyle(){
    return ThemeData (
      primarySwatch: Colors.amber,
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20.0),
      )
    );
  }

  static BoxDecoration mainButtonStyle(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: const DecorationImage(
        image: AssetImage("assets/button_background_0.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }

  static TextStyle buttonTextStyle(){
    return const TextStyle(color: Colors.white);
  }

  static double buttonWidthPercentage(){
    return .4;
  }

  static BoxDecoration mainBottomBar(){
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/stone_wall_0.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }

  static double bottomBarPercentage(){
    return .04;
  }

  static TextStyle bottomBarTextStyle(BuildContext context){
    return TextStyle(
      color: Colors.white,
      fontSize: MediaQuery.of(context).size.width * .04,
      fontWeight: FontWeight.bold,
      fontFamily: 'Helvetica',
    );
  }
}

