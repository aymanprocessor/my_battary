import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:my_battary/provider/cart_provider.dart';
import 'package:my_battary/provider/firebase_auth.dart';
import 'package:my_battary/screens/Shopping_cart.dart';
import 'package:my_battary/screens/login.dart';
import 'package:my_battary/utils/common.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatefulWidget {
  final String name, photoUrl, batterySize, brand, category;
  final int price, quantity;

  SingleProduct(
      {this.name,
      this.photoUrl,
      this.batterySize,
      this.brand,
      this.price,
      this.category,
      this.quantity});

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  Common common;
  ShoppingCart shoppingCart = new ShoppingCart();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    common = new Common();
    shoppingCart = new ShoppingCart();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ShoppingCartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return InkWell(
      onTap: () {
        print('card');
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: widget.batterySize == '675'
                      ? common.blueGradient
                      : widget.batterySize == '312'
                          ? common.brownGradient
                          : widget.batterySize == '13'
                              ? common.orangeGradient
                              : common.yellowGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: common.fontFamily,
                        fontSize: 20.0,
                        package: common.fontPack),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                widget.photoUrl,
                fit: BoxFit.contain,
              ),
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
                              package: common.fontPack),
                        )),
                  ),
                  Container(
                    width: 1.0,
                    color: Colors.black38,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(gradient: common.redGradient),
                      child: IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (authProvider.user != null) {
                              cartProvider.addtoCart({
                                "name": widget.name,
                                "batterySize": widget.batterySize,
                                "price": widget.price,
                                "brand": widget.brand,
                                "photoUrl": widget.photoUrl,
                                "category": widget.category,
                                "quantity": widget.quantity,
                              });
                              Fluttertoast.showToast(
                                  msg: 'تم اضافة البطارية الي القائمة ',
                                  backgroundColor: Colors.greenAccent,
                                  textColor: Colors.black);
                            } else {
                              changeScreen(context, Login());
                            }
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
