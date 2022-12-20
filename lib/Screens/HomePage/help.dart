import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Help",
          style: TextStyle(color: bgcolor),
        ),
        leading: Builder(
            builder: (con) => IconButton(
                  icon: Icon(CupertinoIcons.list_dash, color: bgcolor),
                  onPressed: () => Scaffold.of(con).openDrawer(),
                )),
      ),
      drawer: Mydrawer(),
    );
  }
}
