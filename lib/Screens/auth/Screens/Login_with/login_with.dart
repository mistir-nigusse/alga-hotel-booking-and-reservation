import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Login/login_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Signup/signup_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';

class Loginwith extends StatefulWidget {
  @override
  _LoginwithState createState() => _LoginwithState();
}

class _LoginwithState extends State<Loginwith> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: PageView(pageSnapping: true, children: [
          RegisterBottomSheet(),
          LoginBottomSheet(),
        ]));
  }
}

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedButton3(
              icon: CupertinoIcons.mail_solid,
              text: "Register with Google",
              press: () {},
              color: bgcolor,
            ),
            RoundedButton3(
              icon: CupertinoIcons.mail_solid,
              text: "Register with Linked In",
              press: () {},
              color: bgcolor,
            ),
            RoundedButton3(
              icon: Icons.vpn_key_outlined,
              text: "Register with Email",
              press: () {
                Navigator.pop(context);
                Navigator.push(context, FadePageRoute(widget: SignUpScreen()));
              },
              color: bgcolor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Registerd ?  ",
                    style: TextStyle(color: bgcolor, fontSize: 18),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return new LoginBottomSheet();
                            });
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: bgcolor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
              child: Text(
                "By continuing you agree to the terms and Conditions of Adimera  ",
                style: TextStyle(color: bgcolor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedButton3(
              icon: CupertinoIcons.mail_solid,
              text: "Login with Google",
              press: () {},
              color: bgcolor,
            ),
            RoundedButton3(
              icon: CupertinoIcons.mail_solid,
              text: "Login with Linked In",
              press: () {},
              color: bgcolor,
            ),
            RoundedButton3(
              icon: Icons.vpn_key,
              text: "Login with Email",
              press: () {
                Navigator.pop(context);
                Navigator.push(context, FadePageRoute(widget: LoginScreen()));
              },
              color: bgcolor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Don't have an account ?  ",
                    style: TextStyle(color: bgcolor, fontSize: 18),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return RegisterBottomSheet();
                            });
                      },
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(
                            color: bgcolor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
              child: Text(
                "By continuing you agree to the terms and Conditions of Adimera  ",
                style: TextStyle(color: bgcolor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
