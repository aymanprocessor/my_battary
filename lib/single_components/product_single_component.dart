import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class SingleProduct extends StatefulWidget {
  final String name, photoUrl, batterySize, brand;
  final int price;

  SingleProduct(
      {this.name, this.photoUrl, this.batterySize, this.brand, this.price});

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  final String fontPack = 'google_fonts_arabic';
  final String fontFamily = ArabicFonts.Tajawal;
  final LinearGradient purpleGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.purple[600],
        Colors.purple[700],
        Colors.purple[900]
      ]);
  final LinearGradient greyGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey[300], Colors.grey[400]]);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('card');
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: widget.batterySize == '10'
                    ? Colors.yellow[600]
                    : widget.batterySize == '13'
                        ? Colors.orange
                        : widget.batterySize == '312'
                            ? Colors.brown
                            : Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: fontFamily,
                        fontSize: 20.0,
                        package: fontPack),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Image.asset(
              widget.photoUrl,
              fit: BoxFit.contain,
            )),
            Container(
              height: 1.0,
              color: Colors.black12,
            ),
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.price} ج',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: ArabicFonts.Cairo,
                              fontSize: 20.0,
                              package: fontPack),
                        )),
                  ),
                  Container(
                    width: 1.0,
                    color: Colors.black38,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print('add to cart');
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    // return Card(
    //   elevation: 4.0,
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         flex: 1,
    //         child: Container(
    //           alignment: Alignment.center,
    //           height: 60.0,
    //           width: 70.0,
    //           decoration: BoxDecoration(gradient: linearGradient),
    //           child: Text(
    //             "${widget.price.toString()} ج ",
    //             textAlign: TextAlign.center,
    //             textDirection: TextDirection.rtl,
    //             style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white,
    //                 fontFamily: fontFamily,
    //                 fontSize: 20.0,
    //                 package: fontPack),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //           flex: 2,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: <Widget>[
    //               Text(
    //                 widget.name,
    //                 textAlign: TextAlign.right,
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                     fontFamily: fontFamily,
    //                     fontSize: 15.0,
    //                     package: fontPack),
    //               ),
    //               Text(
    //                 widget.batterySize,
    //                 textAlign: TextAlign.right,
    //                 style: TextStyle(fontFamily: fontFamily, package: fontPack),
    //               )
    //             ],
    //           )),
    //       Expanded(
    //           flex: 1,
    //           child: Image.asset(
    //             widget.photoUrl,
    //             width: 100.0,
    //             height: 60.0,
    //             fit: BoxFit.contain,
    //             alignment: Alignment.center,
    //           ))
    //     ],
    //   ),

    // );
  }
}
