import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProducts {

  Firestore _firestore = Firestore.instance;
  String collection = "products";
  FirebaseUser _user;
  //Future<QuerySnapshot> items;
  List<DocumentSnapshot> items = List<DocumentSnapshot>();

  FirestoreProducts.initialize() {
    init();
  }
  Future<void> init() async {
    _user = await FirebaseAuth.instance.currentUser();
  }
  
}

