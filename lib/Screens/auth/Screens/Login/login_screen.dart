import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/no_internet.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Login/components/login_body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              child: LoginBody(),
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
