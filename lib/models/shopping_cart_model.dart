import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingItem {
  String name, battertSize, brand, type;
  double price;

  ShoppingItem(
      {this.name, this.battertSize, this.brand, this.type, this.price});
}

class ShoppingCart {
  static List<ShoppingItem> shoppingLists;

  ShoppingCart.fromSnapshops(DocumentSnapshot snapshot);

  static List<ShoppingItem> addItem(ShoppingItem item) {
    shoppingLists.add(item);
    return shoppingLists;
  }

  static List<ShoppingItem> removeItem(ShoppingItem item) {
    shoppingLists.remove(item);
    return shoppingLists;
  }
}
