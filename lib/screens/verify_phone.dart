import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_auth.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  TextEditingController smsCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Verify Phone'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextField(
            keyboardType: TextInputType.number,
            controller: smsCode,
            decoration: InputDecoration(hintText: 'Enter Phone Number'),
            onChanged: (value) {
              authProvider.smsOTP = value;
            },
          ),
          new MaterialButton(
            onPressed: () {
              //authProvider.sdsd(context);
            },
            child: new Text('Done'),
            color: Colors.purple,
          )
        ],
      ),
    );
  }
}
