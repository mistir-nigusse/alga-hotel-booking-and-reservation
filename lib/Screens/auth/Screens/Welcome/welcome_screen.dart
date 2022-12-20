import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/no_internet.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool isContainerVisible = true;
    return Scaffold(
        drawer: Mydrawer(),
        body: OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;

              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  child,
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: connected
                          ? Center(
                              child: Body(),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: NoInternet()))
                ],
              );
            },
            child: Stack(
              children: [Container()],
            )));
  }
}
