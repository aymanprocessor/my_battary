import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class FirestoreUser {
  Firestore _firestore = Firestore.instance;
  String collection = "users";
  FirebaseUser _user;

  set setUser(FirebaseUser user) => _user = user;
  FirestoreUser.initialize() {
    init();
  }
  Future<void> init() async {
    _user = await FirebaseAuth.instance.currentUser();
  }

  void createUser(Map<String, dynamic> data) {
    if (_user != null) {
      _firestore.collection(collection).document(_user.uid).get().then((doc) {
        if (!doc.exists) {
          _firestore.collection(collection).document(_user.uid).setData(data);
        }
      });
    }
  }

  void updateUser(Map<String, dynamic> data) {
    if (_user != null) {
      _firestore.collection(collection).document(_user.uid).updateData(data);
    }
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc) {
        if (doc.data == null) {
          return null;
        }
        return UserModel.fromSnap(doc);
      });

  Future<UserModel> getUser() {
    if (_user != null) {
      _firestore.collection(collection).document(_user.uid).get().then((doc) {
        if (doc.data == null) {
          return null;
        }
        return UserModel.fromSnap(doc);
      });
    }
  }
}
