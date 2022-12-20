import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/no_internet.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/otp/components/size_config.dart';
import 'components/otp_body.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String firstname;
  final String middlename;
  final String lastname;
  final String phoneno;
  final String nationality;
  // final String image;

  static String routeName = "/otp";

  const OtpScreen({
    Key? key,
    required this.email,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.phoneno,
    required this.nationality,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                              child: Stack(children: [
                                OTPBody(
                                  firstname: widget.firstname,
                                  middlename: widget.middlename,
                                  lastname: widget.lastname,
                                  phoneno: widget.phoneno,
                                  nationality: widget.nationality,
                                  email: widget.email,
                                  // image: widget.image
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       top: 40.0, left: 20),
                                //   child: IconButton(
                                //       color: bgcolor,
                                //       iconSize: 30,
                                //       icon: Icon(
                                //         CupertinoIcons.arrow_left_circle,
                                //       ),
                                //       onPressed: () {
                                //         Navigator.pop(context);
                                //       }),
                                // )
                              ]),
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
