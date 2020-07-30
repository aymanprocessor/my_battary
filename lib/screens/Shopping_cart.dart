import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_battary/screens/products.dart';
import 'package:my_battary/services/firestore_shopping.dart';
import 'package:my_battary/services/firestore_user.dart';

import 'package:my_battary/utils/common.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/firebase_auth.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  Common common;
  FirestoreUser _firestorUser = FirestoreUser.initialize();
  FirestoreShopping _firestorShopping = FirestoreShopping.initialize();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    common = new Common();
  }

  @override
  void dispose() {
    // TODO: implement dispos

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ShoppingCartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: new AppBar(
          title: new Text(
            'قائمة الطلبات',
            style: TextStyle(
                fontFamily: common.fontFamily, package: common.fontPack),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: common.purpleGradient),
          )),
      body: AnimationLimiter(
          child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 300),
                    child: SlideAnimation(
                        horizontalOffset: 200.0,
                        child: FadeInAnimation(
                            child: Card(
                          elevation: 4.0,
                          //color: Colors.red,
                          margin: EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                  flex: 0,
                                  child: IconButton(
                                      icon:
                                          Icon(Icons.close, color: Colors.red),
                                      onPressed: () {
                                        cartProvider.removeFromCart(
                                            cartProvider.items[index]);
                                      })),
                              new Expanded(
                                  flex: 1,
                                  child: new Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${cartProvider.items[index]['price']} ج',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: common.fontFamily,
                                          package: common.fontPack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0),
                                    ),
                                  )),
                              new Expanded(
                                flex: 2,
                                child: Text(cartProvider.items[index]['name'],
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: common.fontFamily,
                                        package: common.fontPack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0)),
                              ),
                              new Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Image.asset(
                                    cartProvider.items[index]['photoUrl'],
                                    height: 60.0,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.centerRight,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.keyboard_arrow_up),
                                      onPressed: () {
                                        cartProvider.increaseQuantity(index);
                                      },
                                    ),
                                    Text(cartProvider.items[index]['quantity']
                                        .toString()),
                                    IconButton(
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      onPressed: () {
                                        cartProvider.decreaseQuantity(index);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))));
              })),
      bottomNavigationBar: BlocProvider(
        child: Container(
            child: new Row(
          children: <Widget>[
            new Expanded(
              child: new ListTile(
                  title: new Text(
                '${cartProvider.total} جنيه',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 25.0,
                    fontFamily: common.fontFamily,
                    package: common.fontPack,
                    fontWeight: FontWeight.bold),
              )),
            ),
            new Expanded(
                child: new MaterialButton(
              onPressed: () {
                _firestorShopping.createItems({
                  'userId': authProvider.user.uid,
                  'time': DateTime.now().toString(),
                  'items': cartProvider.items,
                  'status': 'pending',
                  'total': cartProvider.total.toString()
                });

                cartProvider.clearItems();
                changeScreen(context, Products());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text('ارسال الطلبات',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: common.fontFamily,
                          package: common.fontPack,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  new Icon(Icons.check_circle, color: Colors.white)
                ],
              ),
              color: Colors.purple,
            ))
          ],
        )),
      ),
    );
  }
}
