import 'package:flutter/material.dart';
import 'package:my_battary/provider/firebase_auth.dart';
import 'package:my_battary/screens/products.dart';
import 'package:my_battary/services/firestore_user.dart';

import 'package:my_battary/single_components/appbar.dart';
import 'package:my_battary/utils/common.dart';
import 'package:provider/provider.dart';
import '../models/government.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final govController = TextEditingController();
  final common = Common();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedGover;

  FirestoreUser _firestorUser = FirestoreUser.initialize();
  List govNames = [
    'أسوان',
    'أسيوط',
    'الأقصر',
    'الإسكندرية',
    'الإسماعيلية',
    'البحر الأحمر',
    'البحيرة',
    'الجيزة',
    'الدقهلية',
    'السويس',
    'الشرقية',
    'الغربية',
    'الفيوم',
    'القاهرة',
    'القليوبية',
    'المنوفية',
    'المنيا',
    'الوادي الجديد',
    'بني سويف',
    'بورسعيد',
    'جنوب سيناء',
    'دمياط',
    'سوهاج',
    'شمال سيناء',
    'قنا',
    'كفر الشيخ',
    'مطروح'
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(govNames);
    _selectedGover = null;
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    govController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List govNames) {
    List<DropdownMenuItem<String>> items = List();

    for (String gover in govNames) {
      items.add(DropdownMenuItem(
        value: gover,
        child: Text(
          gover,
          style: TextStyle(
            fontFamily: common.fontFamily,
            package: common.fontPack,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
    return items;
  }

  onChangeDropdownItem(String selected) {
    setState(() {
      _selectedGover = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: CustomAppBar('تسجيل بيانات'),
        body: new Container(
            margin: EdgeInsets.only(top: 30.0, left: 50.0, right: 50.0),
            child: Form(
              key: _formKey,
              child: new Column(
                children: <Widget>[
                  new Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'مطلوب الاسم';
                        }
                      },
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'الاسم',
                        labelStyle: TextStyle(
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                        errorStyle: TextStyle(
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.purple)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red)),
                      ),
                      controller: nameController,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'مطلوب العنوان';
                        }
                      },
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'العنوان',
                        labelStyle: TextStyle(
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                        errorStyle: TextStyle(
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red)),
                      ),
                      controller: addressController,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'مطلوب المدينة';
                        }
                      },
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'المدينة',
                        labelStyle: TextStyle(
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                        errorStyle: TextStyle(
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red)),
                      ),
                      controller: cityController,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonFormField(
                        validator: (String value) {
                          if (_selectedGover == null) {
                            return 'مطلوب المحافظة';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'المحافظة',
                          labelStyle: TextStyle(
                              fontFamily: common.fontFamily,
                              package: common.fontPack,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                          errorStyle: TextStyle(
                              fontFamily: common.fontFamily,
                              package: common.fontPack,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: Colors.red)),
                        ),
                        isDense: true,
                        value: _selectedGover ?? _selectedGover,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _firestorUser.setUser = authProvider.user;
                        _firestorUser.updateUser({
                          'name': nameController.text.trim(),
                          'address': addressController.text.trim(),
                          'city': cityController.text.trim(),
                          'government': _selectedGover,
                        });
                        changeScreenReplacement(context, Products());
                      }
                    },
                    child: Text('تـــم',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    color: Colors.purple,
                  )
                ],
              ),
            )));
  }
}
