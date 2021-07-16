import 'package:flutter/material.dart';
import 'package:my_battary/single_components/appbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('الخدمات'),
      body: Container(
          child: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          Card(
            
            child: Row(
              children: <Widget>[
                Icon(Icons.access_alarm),
                Text('صيانة السماعة')
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Icon(Icons.access_alarm),
                Text('برمجة السماعة')
              ],
            ),
          )
        ],
      )),
    );
  }
}
