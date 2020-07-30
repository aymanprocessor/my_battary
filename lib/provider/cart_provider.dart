import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_battary/services/firestore_user.dart';

class ShoppingCartProvider with ChangeNotifier {
  Firestore _firestore = Firestore.instance;
  String collection = "shoppings";
  FirebaseUser _user;
  List<DocumentSnapshot> ordersItems = [];
  set user(FirebaseUser user) => _user = user;
  double total = 0;
  List items = [];

  addtoCart(item) {
    items.add(item);
    sumItems();
    notifyListeners();
  }

  removeFromCart(item) {
    items.remove(item);
    sumItems();
    notifyListeners();
  }

  sumItems() {
    total = items
        .map((e) => e['price'] * e['quantity'])
        .fold(0, (previousValue, element) => previousValue + element);
    notifyListeners();
  }

  clearItems() {
    items.clear();
    notifyListeners();
  }

  increaseQuantity(int index) {
    items[index]['quantity']++;
    sumItems();
    notifyListeners();
  }

  decreaseQuantity(int index) {
    if (items[index]['quantity'] > 0) {
      items[index]['quantity']--;
      sumItems();
      notifyListeners();
    }
  }

  getOrdersItems() {
    _firestore
        .collection(collection)
        .where('userId', isEqualTo: _user.uid)
        .snapshots()
        .listen((data) {
      ordersItems = data.documents;
      notifyListeners();
    });
  }
}
