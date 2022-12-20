import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class ErrorPage extends StatefulWidget {
  final Widget backwidget;
  const ErrorPage({Key? key, required this.backwidget}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_image.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: bgcolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => widget.backwidget));
              },
              child: Text(
                "Try Again".toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ErrorPage2 extends StatefulWidget {
  final Widget backwidget;
  const ErrorPage2(
      {Key? key, required this.messagetext, required this.backwidget})
      : super(key: key);
  final String messagetext;
  @override
  _ErrorPage2State createState() => _ErrorPage2State();
}

class _ErrorPage2State extends State<ErrorPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_image.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Container(
              height: 80,
              width: 100,
              color: Colors.white,
            ),
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              widget.messagetext,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              widget.backwidget));
                },
                child: Text(
                  'Retry',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}
