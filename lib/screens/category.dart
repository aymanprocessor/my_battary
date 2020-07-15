import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:my_battary/screens/products.dart';

class Category extends StatelessWidget {
  final String fontPack = 'google_fonts_arabic';
  final String fontFamily = ArabicFonts.Tajawal;
  final LinearGradient linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.purple[600],
        Colors.purple[700],
        Colors.purple[900]
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("نوع سماعتك",
              style: TextStyle(fontFamily: fontFamily, package: fontPack)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: linearGradient),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Products(types: 'normal')));
              },
              child: Card(
                  borderOnForeground: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  elevation: 3.0,
                  margin: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/phonak.png',
                        width: 250.0,
                        height: 250.0,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                            gradient: linearGradient,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        child: Text(
                          'السماعة',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFamily,
                              package: fontPack,
                              fontSize: 25.0),
                        ),
                      )
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Products(types: 'cochlear')));
              },
              child: Card(
                  borderOnForeground: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  elevation: 3.0,
                  margin: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/cochlear.png',
                        width: 250.0,
                        height: 250.0,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                            gradient: linearGradient,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        child: Text(
                          'القوقعة',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFamily,
                              package: fontPack,
                              fontSize: 25.0),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
