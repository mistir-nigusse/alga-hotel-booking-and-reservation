import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/body.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return ErrorContent(
                controller: animationController,
              );
            }));
  }
}
