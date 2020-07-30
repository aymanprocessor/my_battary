import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_battary/screens/login.dart';
import 'package:my_battary/screens/products.dart';
import 'package:my_battary/screens/user_form.dart';
import 'package:my_battary/screens/verify_phone.dart';
import '../utils/common.dart';
import '../models/user_model.dart';
import 'package:my_battary/services/firestore_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firestore_user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  static const LOGGEDIN = 'loggedIn';
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  FirestoreUser _firestorUser = FirestoreUser.initialize();
  UserModel _userModel;
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _firebaseUser;

  FirebaseUser _firebaseUser;
  String smsOTP;
  int _code;
  String verificationId;
  String errorMessage = "";
  AuthCredential _phoneAuthCredential;
  bool loggedIn = false;
  bool loading = false;
  bool codeSent = false;
  AuthProvider.initialize() {
    //readPrefs();

    init();
  }
  Future<void> init() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    _auth = FirebaseAuth.instance;
    notifyListeners();
  }

  Future<void> readPrefs() async {
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loggedIn = prefs.getBool(LOGGEDIN) ?? false;

      if (loggedIn) {
        _user = await _auth.currentUser();
        _userModel = await _firestorUser.getUserById(_user.uid);
        notifyListeners();
        return;
      }
    });
  }

  handleError(error, BuildContext context) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print('The verification code is invalid');
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((AuthResult authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser);

        if (_firebaseUser != null) {
          _firestorUser.createUser({
            "id": _firebaseUser.uid,
            "phoneNumber": _firebaseUser.phoneNumber,
            "favs": [],
            "orders": []
          });
        }
        Firestore.instance
            .collection('users')
            .document(_firebaseUser.uid)
            .get()
            .then((value) {
          if (!value.data.containsKey('name')) {
            changeScreen(context, UserForm());
            this.codeSent = false;
          } else {
            changeScreen(context, Products());
            this.codeSent = false;
          }
        });
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> verifyPhone(BuildContext context, String _phoneNumber) async {
    String phoneNumber = "+2" + _phoneNumber.trim();
    print(phoneNumber);
    notifyListeners();

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');

      this._phoneAuthCredential = phoneAuthCredential;
      _login(context);

      print(phoneAuthCredential);
      notifyListeners();
    }

    void verificationFailed(AuthException error) {
      print('verificationFailed');
      print(error.message);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this.verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());
      this.codeSent = true;
      notifyListeners();
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      print(verificationId);
      this.verificationId = verificationId;
      notifyListeners();
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> submitOTP(BuildContext context) async {
    String smsCode = this.smsOTP.trim();

    this._phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: smsCode);
    notifyListeners();
    _login(context);
    //changeScreen(context, UserForm());
  }

  Future<void> signOut() async {
    try {
      // signout code
      await _auth.signOut();
      _firebaseUser = null;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
