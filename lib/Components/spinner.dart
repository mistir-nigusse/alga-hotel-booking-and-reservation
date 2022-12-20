import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Spinner extends StatefulWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpinKitCubeGrid(
      size: 35,
      color: bgcolor,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1200)),
    );
  }
}
