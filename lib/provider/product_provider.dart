import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  Firestore _firestore = Firestore.instance;
  String collection = "products";
  FirebaseUser _user;
  List<DocumentSnapshot> items = [];
  List<DocumentSnapshot> itemsByCat = [];

  getProductItems() {
    _firestore.collection(collection).getDocuments().then((snapshot) {
      items = snapshot.documents;
      notifyListeners();
    });
  }

  // List<DocumentSnapshot> getProductItemsByCat(String category) {
  //   List<DocumentSnapshot> items = [];
  //   _firestore
  //       .collection(collection)
  //       .where('category', isEqualTo: category)
  //       .snapshots()
  //       .listen((snapshot) {
  //     items = (snapshot.documents);
  //   });
  //   return items;
  // }

}

Stream<List<DocumentSnapshot>> getProductItems() {
  return Firestore.instance
      .collection('products')
      .snapshots()
      .map((event) => event.documents);
}
