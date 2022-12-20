import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/otp/components/size_config.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);
const bgcolorhex = Color(0XFF318972);
Color bgcolor = Color(0XFF318972);
const bgcolor2 = Color(0XFFEEEEEE);
const kDefaultPaddin = 20.0;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
