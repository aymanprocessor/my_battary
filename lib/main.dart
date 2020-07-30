import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_battary/provider/cart_provider.dart';
import 'package:my_battary/provider/firebase_auth.dart';
import 'package:my_battary/provider/product_provider.dart';

import 'package:my_battary/screens/products.dart';

import 'package:provider/provider.dart';
import 'provider/cart_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider.initialize()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        StreamProvider<List<DocumentSnapshot>>(create: (_) => getProductItems())
      ],
      child: MaterialApp(
        title: 'My Battery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Products(),
      ),
    );
  }
}
