import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:my_battary/single_components/product_single_component.dart';
import 'package:my_battary/utils/enum.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Products extends StatefulWidget {
  final String types;

  Products({this.types});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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

  final cochlearProducts = [
    {
      "name": "باور وان",
      "photoUrl": "images/powerone-implant-p675.jpeg",
      "batterySize": "675",
      "price": 400,
    },
    {
      "name": "رايوفاك",
      "photoUrl": "images/Rayovac-675-Implant.jpg",
      "batterySize": "675",
      "price": 500,
    }
  ];

  final normalProducts = [
    {
      "name": "باور وان - 10",
      "photoUrl": "images/Power-One-10.jpg",
      "batterySize": "10",
      "price": 200,
    },
    {
      "name": "باور وان - 13",
      "photoUrl": "images/Power-One-13.jpg",
      "batterySize": "13",
      "price": 270,
    },
    {
      "name": "باور وان - 312",
      "photoUrl": "images/Power-One-312.jpg",
      "batterySize": "312",
      "price": 320,
    },
    {
      "name": "باور وان - 675",
      "photoUrl": "images/Power-One-675.jpg",
      "batterySize": "675",
      "price": 450,
    },
    {
      "name": "رايوفاك - 10",
      "photoUrl": "images/Rayovac-10.jpg",
      "batterySize": "10",
      "price": 170,
    },
    {
      "name": "رايوفاك - 13",
      "photoUrl": "images/Rayovac-13.jpg",
      "batterySize": "13",
      "price": 220,
    },
    {
      "name": "رايوفاك - 312",
      "photoUrl": "images/Rayovac-312.jpg",
      "batterySize": "312",
      "price": 260,
    },
    {
      "name": "رايوفاك - 675",
      "photoUrl": "images/Rayovac-675.jpg",
      "batterySize": "675",
      "price": 350,
    },
    {
      "name": "اوتيكون - 10",
      "photoUrl": "images/oticon_10.jpg",
      "batterySize": "10",
      "price": 120,
    },
    {
      "name": "اوتيكون - 13",
      "photoUrl": "images/oticon_13.jpg",
      "batterySize": "13",
      "price": 170,
    },
    {
      "name": "اوتيكون - 312",
      "photoUrl": "images/oticon_312.jpg",
      "batterySize": "312",
      "price": 260,
    },
  ];

  var sss = ['10', '13', '312', '675'];
  var sasa = ['10', '12', '13', '17', '312', '675'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("اختار بطاريتك",
              style: TextStyle(fontFamily: fontFamily, package: fontPack)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: linearGradient),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
          ],
        ),
        body: new ListView.builder(
          itemCount: sss.length,
          itemBuilder: (context, index) {
            return new StickyHeader(
                header: new Text(
                  sss[index],
                  style: TextStyle(color: Colors.amber),
                ),
                content: new Column(
                    children: sasa.map((val) {
                  if (!val.contains(sss[index])) return SizedBox.shrink();
                  return new Text(val);
                }).toList()));
          },
        )
        // body: GridView.builder(
        //   itemCount: widget.types == 'cochlear'
        //        cochlearProducts.length
        //       : normalProducts.length,
        //   itemBuilder: (context, index) {
        //     if (widget.types == 'cochlear') {
        //       return StickyHeader(
        //         header: new Container(
        //           height: 50.0,
        //           color: Colors.blueGrey[700],
        //           padding: new EdgeInsets.symmetric(horizontal: 16.0),
        //           alignment: Alignment.centerLeft,
        //           child: new Text(
        //             '',
        //             style: const TextStyle(color: Colors.white),
        //           ),
        //         ),
        //         content: SingleProduct(
        //           name: cochlearProducts[index]['name'],
        //           price: cochlearProducts[index]['price'],
        //           photoUrl: cochlearProducts[index]['photoUrl'],
        //           batterySize: cochlearProducts[index]['batterySize'],
        //         ),
        //       );
        //     } else {
        //       return SingleProduct(
        //         name: normalProducts[index]['name'],
        //         price: normalProducts[index]['price'],
        //         photoUrl: normalProducts[index]['photoUrl'],
        //         batterySize: normalProducts[index]['batterySize'],
        //       );
        //     }
        //   },
        //   gridDelegate:
        //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        // ),
        );
  }
}
