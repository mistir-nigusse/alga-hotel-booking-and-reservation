import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class ReservationInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  String? DataText;
  final double size;

  ReservationInputField({
    key,
    required this.hintText,
    required this.icon,
    required this.size,
    required this.DataText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: size,
              decoration: BoxDecoration(
                border: Border.all(color: bgcolor, width: 2),
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      icon,
                      color: kPrimaryColor,
                    ),
                  ),
                  AutoSizeText("$DataText")
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              hintText,
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}

class ReservationDateInputField extends StatelessWidget {
  final String hintText;

  final double size;
  final Function buttonfunction;
  final IconData icons;
  final Widget data;
  final Color hintcolor;
  const ReservationDateInputField({
    key,
    required this.hintText,
    required this.size,
    required this.buttonfunction,
    required this.icons,
    required this.data,
    required this.hintcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  buttonfunction();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                    width: size,
                    decoration: BoxDecoration(
                      border: Border.all(color: bgcolor, width: 2),
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: data),
              ),
              // IconButton(
              //     onPressed: () {
              //       buttonfunction();
              //     },
              //     icon: Icon(
              //       icons,
              //       size: 30,
              //       color: bgcolor,
              //     )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              hintText,
              style: TextStyle(color: hintcolor, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
