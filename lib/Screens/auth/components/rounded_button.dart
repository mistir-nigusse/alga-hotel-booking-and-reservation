import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          onPressed: () {
            press();
          },
          style: TextButton.styleFrom(
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

class RoundedButton2 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton2({
    key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
      ),
      child: TextButton(
        onPressed: () {
          press();
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class RoundedButton3 extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function press;
  final Color color, textColor;
  const RoundedButton3({
    key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = kPrimaryColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 60,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0),
              topRight: Radius.circular(45.0),
              bottomLeft: Radius.circular(45.0),
              bottomRight: Radius.circular(45.0))),
      child: TextButton(
        onPressed: () {
          press();
        },
        style: ButtonStyle(
            // backgroundColor: color,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: color)))
            // backgroundColor: color,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Icon(
              icon,
              color: color,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton4 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double widthsize;
  const RoundedButton4({
    key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = kPrimaryColor,
    required this.widthsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 60,
      width: widthsize,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0),
              topRight: Radius.circular(45.0),
              bottomLeft: Radius.circular(45.0),
              bottomRight: Radius.circular(45.0))),
      child: TextButton(
        onPressed: () {
          press();
        },
        style: ButtonStyle(
            // backgroundColor: color,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: color)))
            // backgroundColor: color,
            ),
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RoundedButton5 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double size;
  const RoundedButton5({
    key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = kPrimaryColor,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 40,
      width: size,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0),
              topRight: Radius.circular(45.0),
              bottomLeft: Radius.circular(45.0),
              bottomRight: Radius.circular(45.0))),
      child: TextButton(
        onPressed: () {
          press();
        },
        style: ButtonStyle(
            // backgroundColor: color,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: color)))
            // backgroundColor: color,
            ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
