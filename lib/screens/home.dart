import 'package:flutter/material.dart';
import 'package:my_battary/single_components/appbar.dart';
import 'package:my_battary/utils/common.dart';
import 'package:my_battary/utils/icon_gradient.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Common common = new Common();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('خدمات'), 
      body: Container(
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Card(
              elevation: 3.0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconGradient(
                        child: Icon(
                          Icons.hearing,
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                      Text('شراء البطاريات',
                          style: TextStyle(
                              fontFamily: common.fontFamily,
                              package: common.fontPack,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3.0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconGradient(
                        child: Icon(
                          Icons.gps_fixed,
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                      Text('صيانة السماعة',
                          style: TextStyle(
                              fontFamily: common.fontFamily,
                              package: common.fontPack,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3.0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconGradient(
                        child: Icon(
                          Icons.texture,
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                      Text('برمجة السماعة',
                          style: TextStyle(
                              fontFamily: common.fontFamily,
                              package: common.fontPack,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
