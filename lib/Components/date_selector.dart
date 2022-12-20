import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class DateSelector extends StatefulWidget {
  final Widget datepicker;
  const DateSelector({Key? key, required this.datepicker}) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime datetime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: bgcolor, width: 2),
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.datepicker);
  }
}

class TimeSelector extends StatefulWidget {
  const TimeSelector({Key? key, required this.timepicker}) : super(key: key);
  final Widget timepicker;
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? datetime = TimeOfDay?.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width * 0.6,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: bgcolor, width: 2),
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.timepicker);
  }
}
