import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:my_battary/provider/cart_provider.dart';
import 'package:my_battary/provider/firebase_auth.dart';
import 'package:my_battary/provider/product_provider.dart';
import 'package:my_battary/screens/orders.dart';

import 'package:my_battary/single_components/product_single_component.dart';
import 'package:my_battary/utils/common.dart';
import 'package:my_battary/utils/enum.dart';
import 'package:my_battary/utils/icon_gradient.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../provider/firebase_auth.dart';

import 'Shopping_cart.dart';
import 'login.dart';

class Products extends StatefulWidget {
  final String types;

  Products({this.types});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final common = Common();
  IconGradient iconGradient;

  FirebaseUser _firebaseUser;
  final products = [
    {
      "name": "باور وان",
      "photoUrl": "images/powerone-implant-p675.jpeg",
      "batterySize": "675",
      "price": 400,
      "category": "cochlear",
      'quantity': 1
    },
    {
      "name": "رايوفاك",
      "photoUrl": "images/Rayovac-675-Implant.jpg",
      "batterySize": "675",
      "price": 500,
      "category": "cochlear",
      'quantity': 1
    },
    {
      "name": "باور وان - 10",
      "photoUrl": "images/Power-One-10.jpg",
      "batterySize": "10",
      "price": 200,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "باور وان - 13",
      "photoUrl": "images/Power-One-13.jpg",
      "batterySize": "13",
      "price": 270,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "باور وان - 312",
      "photoUrl": "images/Power-One-312.jpg",
      "batterySize": "312",
      "price": 320,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "باور وان - 675",
      "photoUrl": "images/Power-One-675.jpg",
      "batterySize": "675",
      "price": 450,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "رايوفاك - 10",
      "photoUrl": "images/Rayovac-10.jpg",
      "batterySize": "10",
      "price": 170,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "رايوفاك - 13",
      "photoUrl": "images/Rayovac-13.jpg",
      "batterySize": "13",
      "price": 220,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "رايوفاك - 312",
      "photoUrl": "images/Rayovac-312.jpg",
      "batterySize": "312",
      "price": 260,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "رايوفاك - 675",
      "photoUrl": "images/Rayovac-675.jpg",
      "batterySize": "675",
      "price": 350,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "اوتيكون - 10",
      "photoUrl": "images/oticon_10.jpg",
      "batterySize": "10",
      "price": 120,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "اوتيكون - 13",
      "photoUrl": "images/oticon_13.jpg",
      "batterySize": "13",
      "price": 170,
      "category": "normal",
      'quantity': 1
    },
    {
      "name": "اوتيكون - 312",
      "photoUrl": "images/oticon_312.jpg",
      "batterySize": "312",
      "price": 260,
      "category": "normal",
      'quantity': 1
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    iconGradient = new IconGradient();

    _getFirebaeUser();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final cartProvider = Provider.of<ShoppingCartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    this._firebaseUser = authProvider.user;
    productProvider.getProductItems();
    //final List<DocumentSnapshot> products = productProvider.items;

    //productProvider.getProductItemsByCat('normal');

    // final normalProducts = products
    //     .where((DocumentSnapshot documentSnapshot) =>
    //         documentSnapshot.data['category'] == 'normal')
    //     .toList();

    // final cochlearProducts = products
    //     .where((DocumentSnapshot documentSnapshot) =>
    //         documentSnapshot.data['category'] == 'cochlear')
    //     .toList();

    final normalProducts = products
        .where((documentSnapshot) => documentSnapshot['category'] == 'normal')
        .toList();

    final cochlearProducts = products
        .where((documentSnapshot) => documentSnapshot['category'] == 'cochlear')
        .toList();
    TextStyle textStyle = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: common.fontFamily,
        package: common.fontPack);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                'السماعة',
                style: textStyle,
              ),
            ),
            Tab(
              child: Text(
                'القوقعة',
                style: textStyle,
              ),
            )
          ]),
          title: Text("اختار بطاريتك",
              style: TextStyle(
                  fontFamily: common.fontFamily, package: common.fontPack)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: common.purpleGradient),
          ),
          actions: <Widget>[
            Badge(
              badgeColor: Colors.red,
              position: BadgePosition.topRight(top: 5.0, right: 5.0),
              showBadge: cartProvider.items.length > 0 ? true : false,
              badgeContent: Text(cartProvider.items.length.toString(),
                  style: TextStyle(color: Colors.white)),
              child: IconButton(
                  iconSize: 32.0,
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    if (_firebaseUser != null) {
                      changeScreen(context, ShoppingCart());
                    } else {
                      changeScreen(context, Login());
                    }
                  }),
            )
          ],
        ),
        body: TabBarView(children: [
          BuildGridView(products: normalProducts),
          BuildGridView(products: cochlearProducts)
        ]),
        drawer: new Drawer(
            child: new ListView(
          children: <Widget>[
            // new UserAccountsDrawerHeader(
            //   accountEmail: new Text('Fake_Email@Fake.com'),
            //   accountName: new Text('Fake Name'),
            //   currentAccountPicture: GestureDetector(
            //       child: new CircleAvatar(
            //     backgroundColor: Colors.white54,
            //   )),
            //   decoration: BoxDecoration(gradient: common.purpleGradient),
            // ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Products()));
              },
              child: new ListTile(
                title: new Text(
                  'الرئيسية',
                  style: textStyle,
                ),
                leading: IconGradient(
                  child: Icon(Icons.home, color: Colors.white, size: 30.0),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (authProvider.user != null) {
                  Navigator.pop(context);
                  changeScreen(context, Orders());
                } else {
                  Navigator.pop(context);
                  changeScreen(context, Login());
                }
              },
              child: new ListTile(
                title: new Text(
                  'متابعة طلباتي',
                  style: textStyle,
                ),
                leading: IconGradient(
                  child: Icon(Icons.view_list, color: Colors.white, size: 30.0),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (authProvider.user != null) {
                  Navigator.pop(context);
                  changeScreen(context, ShoppingCart());
                } else {
                  Navigator.pop(context);
                  changeScreen(context, Login());
                }
              },
              child: new ListTile(
                title: new Text(
                  'قائمة الطلبات',
                  style: textStyle,
                ),
                leading: Badge(
                  badgeColor: Colors.red,
                  position: BadgePosition.topRight(top: -6.0, right: -8.0),
                  showBadge: cartProvider.items.length > 0 ? true : false,
                  badgeContent: Text(cartProvider.items.length.toString(),
                      style: TextStyle(color: Colors.white)),
                  child: IconGradient(
                    child: Icon(Icons.shopping_cart,
                        color: Colors.white, size: 30.0),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {},
            //   child: new ListTile(
            //     title: new Text(
            //       'مفضلاتي',
            //       style: textStyle,
            //     ),
            //     leading: IconGradient(
            //       child: Icon(Icons.favorite, color: Colors.white, size: 30.0),
            //     ),
            //   ),
            // ),

            authProvider.user != null
                ? InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      authProvider.signOut();
                    },
                    child: new ListTile(
                      title: new Text(
                        'تسجيل الخروج',
                        style: textStyle,
                      ),
                      leading: IconGradient(
                        child: Icon(Icons.exit_to_app,
                            color: Colors.white, size: 30.0),
                      ),
                    ),
                  )
                : Container()
          ],
        )),
      ),
    );
  }

  Future<void> _getFirebaeUser() async {
    if (_firebaseUser != null) {
      print("FirebaseUser" + this._firebaseUser.phoneNumber);
    } else {
      print('User is not exists');
    }
  }
}

class BuildGridView extends StatelessWidget {
  const BuildGridView({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List products;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        itemCount: products.length,
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 2,
              child: ScaleAnimation(
                  duration: const Duration(milliseconds: 500),
                  child: FadeInAnimation(
                      child: SingleProduct(
                    name: products[index]['name'],
                    price: products[index]['price'],
                    photoUrl: products[index]['photoUrl'],
                    batterySize: products[index]['batterySize'],
                    category: products[index]['category'],
                    quantity: products[index]['quantity'],
                  ))));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      ),
    );
  }
}
