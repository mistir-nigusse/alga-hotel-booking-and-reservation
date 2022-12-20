import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class ReservationDialogue extends StatefulWidget {
  const ReservationDialogue({Key? key}) : super(key: key);

  @override
  _ReservationDialogueState createState() => _ReservationDialogueState();
}

class _ReservationDialogueState extends State<ReservationDialogue> {
  DateTime datetime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width * 0.72,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: bgcolor, width: 2),
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(Icons.check_circle, size: 50, color: bgcolor),
            Text(
              "Your Reserved room Will be available only for 2 hours before the reservation expires.Please pay to book through online paymnet or to the hotel reception in person.",
              style: TextStyle(
                  color: bgcolor, fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
          ],
        ));
  }
}

class ReservationDialogueWithError extends StatefulWidget {
  const ReservationDialogueWithError({Key? key, required this.messagetext})
      : super(key: key);
  final String messagetext;
  @override
  _ReservationDialogueWithErrorState createState() =>
      _ReservationDialogueWithErrorState();
}

class _ReservationDialogueWithErrorState
    extends State<ReservationDialogueWithError> {
  DateTime datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width * 0.72,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          border: Border.all(color: bgcolor, width: 2),
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(Icons.check_circle, size: 50, color: bgcolor),
            Text(
              widget.messagetext,
              style: TextStyle(
                  color: bgcolor, fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
          ],
        ));
  }
}
