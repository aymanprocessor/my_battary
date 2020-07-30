import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class FirestoreShopping {
  Firestore _firestore = Firestore.instance;
  String collection = "shoppings";
  FirebaseUser _user;
  //Future<QuerySnapshot> items;
  List<DocumentSnapshot> items = List<DocumentSnapshot>();

  FirestoreShopping.initialize() {
    init();
  }
  Future<void> init() async {
    _user = await FirebaseAuth.instance.currentUser();
  }

  void createItems(Map<String, dynamic> data) {
    _firestore
        .collection(collection)
        .document(DateTime.now().millisecondsSinceEpoch.toString())
        .setData(data);
  }

  void updateItems(Map<String, dynamic> data) {
    _firestore
        .collection(collection)
        .document(DateTime.now().millisecondsSinceEpoch.toString())
        .updateData(data);
  }

  
}
