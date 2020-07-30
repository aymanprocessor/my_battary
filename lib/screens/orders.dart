import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_battary/provider/cart_provider.dart';
import 'package:my_battary/provider/firebase_auth.dart';
import 'package:my_battary/services/firestore_shopping.dart';
import 'package:my_battary/single_components/appbar.dart';
import 'package:my_battary/utils/common.dart';
import 'package:my_battary/utils/icon_gradient.dart';
import 'package:provider/provider.dart';
import 'package:steps_indicator/steps_indicator.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Common common = Common();
  int currentStep = 1;
  IconGradient iconGradient = IconGradient();
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ShoppingCartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    cartProvider.user = authProvider.user;
    cartProvider.getOrdersItems();
    @override
    List<DocumentSnapshot> items = cartProvider.ordersItems.reversed.toList();
    return Scaffold(
      appBar: CustomAppBar('متابعة طلباتي'),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: double.infinity,
                    decoration: BoxDecoration(gradient: common.purpleGradient),
                    child: Text(
                        intl.DateFormat('dd-MM-yyyy  h:mm aa').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(items[index].documentID))),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: common.fontFamily,
                            package: common.fontPack,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0)),
                  ),
                  Column(
                    children: [
                      for (var data in items[index].data['items'])
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Expanded(
                                    flex: 1,
                                    child: new Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${data['price']} ج',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: common.fontFamily,
                                            package: common.fontPack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0),
                                      ),
                                    )),
                                new Expanded(
                                  flex: 2,
                                  child: Text(data['name'],
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: common.fontFamily,
                                          package: common.fontPack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0)),
                                ),
                                new Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Image.asset(
                                      data['photoUrl'],
                                      height: 60.0,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                        'X ' + data['quantity'].toString(),
                                        style: TextStyle(
                                            fontFamily: common.fontFamily,
                                            package: common.fontPack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      Container(
                        color: Colors.amberAccent,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                          '${items[index].data['total']} ج',
                                          style: TextStyle(
                                              fontFamily: common.fontFamily,
                                              package: common.fontPack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0)),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text('الاجمالي',
                                          style: TextStyle(
                                              fontFamily: common.fontFamily,
                                              package: common.fontPack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0)),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                              child: items[index].data['status'] == 'pending'
                                  ? SingleStep(
                                      common: common,
                                      title: 'جاري الشحن',
                                      color: Colors.grey,
                                      textColor: Colors.grey,
                                    )
                                  : items[index].data['status'] == 'confirmed'
                                      ? SingleStep(
                                          common: common,
                                          title: 'جاري الشحن',
                                          color: Colors.orange,
                                          textColor: Colors.orange,
                                        )
                                      : SingleStep(
                                          common: common,
                                          title: 'تم الشحن',
                                          color: Colors.green,
                                          textColor: Colors.green,
                                        )),
                          Expanded(
                              child: items[index].data['status'] == 'pending'
                                  ? SingleStep(
                                      common: common,
                                      title: 'جاري التأكيد',
                                      color: Colors.orange,
                                      textColor: Colors.orange,
                                    )
                                  : items[index].data['status'] == 'confirmed'
                                      ? SingleStep(
                                          common: common,
                                          title: 'تم التأكيد',
                                          color: Colors.green,
                                          textColor: Colors.green,
                                        )
                                      : SingleStep(
                                          common: common,
                                          title: 'تم التأكيد',
                                          color: Colors.green,
                                          textColor: Colors.green,
                                        )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: items.length),
    );
  }
}

class SingleStep extends StatelessWidget {
  const SingleStep(
      {Key key,
      @required this.common,
      @required this.title,
      this.color = Colors.black,
      this.textColor = Colors.black})
      : super(key: key);

  final Common common;
  final String title;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Icon(Icons.check_circle, color: this.color, size: 40.0),
          SizedBox(
            height: 10.0,
          ),
          Text(title,
              style: TextStyle(
                  color: this.textColor,
                  fontFamily: common.fontFamily,
                  package: common.fontPack,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0))
        ],
      ),
    );
  }
}
