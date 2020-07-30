import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class Common {
  final LinearGradient purpleGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.purple[600],
        Colors.purple[700],
        Colors.purple[900]
      ]);

  final LinearGradient blueGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.blue[600], Colors.blue[900]]);
  final LinearGradient brownGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.brown[600], Colors.brown[900]]);

  final LinearGradient orangeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.orange[700], Colors.orange[900]]);

  final LinearGradient yellowGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.yellow[400],
        Colors.yellow[800],
      ]);

  final LinearGradient redGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.red[400],
        Colors.red[600],
      ]);

  final String fontPack = 'google_fonts_arabic';
  final String fontFamily = ArabicFonts.Tajawal;
}

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

// request here
void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
