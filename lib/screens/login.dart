import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:my_battary/provider/firebase_auth.dart';
import 'package:my_battary/single_components/appbar.dart';
import 'package:my_battary/utils/common.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Common common = Common();
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: CustomAppBar('تسجيل الدخول'),
        body: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 30.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.phone_android,
                size: 200.0,
                color: Colors.purple[100],
              ),
              SizedBox(
                height: 20.0,
              ),
              new TextField(
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  keyboardType: authProvider.codeSent
                      ? TextInputType.number
                      : TextInputType.phone,
                  controller: _editingController,
                  decoration: authProvider.codeSent
                      ? InputDecoration(
                          labelText: 'Verification Code',
                          labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.purple[800],
                              fontWeight: FontWeight.bold),
                          prefixIcon:
                              Icon(Icons.call, color: Colors.purpleAccent),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purple[800], width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purpleAccent)))
                      : InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.purple[800],
                              fontWeight: FontWeight.bold),
                          hintText: 'Ex : 01012345678',
                          prefixIcon: Icon(Icons.stay_current_portrait,
                              color: Colors.purple[800]),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purpleAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purpleAccent)))),
              SizedBox(
                height: 40.0,
              ),
              new MaterialButton(
                onPressed: () {
                  if (authProvider.codeSent) {
                    authProvider.smsOTP = _editingController.text;
                    authProvider.submitOTP(context);
                  } else {
                    authProvider.verifyPhone(context, _editingController.text);

                    _editingController.clear();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: authProvider.codeSent
                      ? new Text('Submit Code',
                          style: TextStyle(color: Colors.white, fontSize: 17.0))
                      : new Text(
                          'Verify Phone Number',
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                ),
                color: Colors.purple,
              ),
            ],
          ),
        ));
  }
}
