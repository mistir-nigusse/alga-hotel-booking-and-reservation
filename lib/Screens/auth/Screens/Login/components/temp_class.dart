import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/homepage.dart';

class TempClass extends StatefulWidget {
  const TempClass({Key? key, required this.token}) : super(key: key);
  final String token;
  @override
  _TempClassState createState() => _TempClassState();
}

class _TempClassState extends State<TempClass> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Navigator.push(
      //     context,
      //     FadePageRoute(
      //         widget: Homepage(
      //       token: widget.token,
      //     )));
      Get.offAll(() => Homepage(
            token: widget.token,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width / 2,
      ),
    );
  }
}
