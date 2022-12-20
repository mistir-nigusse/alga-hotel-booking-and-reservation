import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/homepage.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/welcome_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Startpage/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Springboardpage extends StatefulWidget {
  @override
  _SpringboardpageState createState() => _SpringboardpageState();
}

class _SpringboardpageState extends State<Springboardpage> {
  final VariablesController variableController = Get.put(VariablesController());
  // late Timer timer;
  @override
  void initState() {
    super.initState();
    showprogress();
  }

  showprogress() async {
    await Future.delayed(Duration(seconds: 3));
    onboardlauncher();
  }

  onboardlauncher() async {
    setvisitingFlag();
    bool visitingflag = await getvisitingFlag();

    if (visitingflag == true) {
      variableController.getoken() != ""
          ? Navigator.pushReplacement(
              context,
              FadePageRoute(
                  widget: Homepage(
                token: variableController.getoken(),
              )))
          : Navigator.pushReplacement(
              context, FadePageRoute(widget: onBoardingPage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => onBoardingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/logo.png",
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child:
                    Center(child: CircularProgressIndicator(color: bgcolor))),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

setvisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("alreadyvisited", true);
}

getvisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool alreadyvisited = preferences.getBool("alreadyvisited") ?? false;
  return alreadyvisited;
}
