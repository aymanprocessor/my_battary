import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const PHONENUMBER = 'phoneNumber';
  static const ID = 'id';

  String _phoneNumber;
  String _id;

  String get phoneNumber => _phoneNumber;
  String get id => _id;

  UserModel.fromSnap(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _phoneNumber = snapshot.data[PHONENUMBER];
  }
}
