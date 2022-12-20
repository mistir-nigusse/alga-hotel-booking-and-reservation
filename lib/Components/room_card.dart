import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Roomcard extends StatelessWidget {
  final floorNo;
  final roomindex;
  final roomNo;
  final roomStaus;
  final Function onpress;
  const Roomcard(
      {Key? key,
      required this.floorNo,
      required this.roomNo,
      required this.roomStaus,
      this.roomindex,
      required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onpress();
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          // height: MediaQuery.of(context).size.height / 2.8,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
            border: Border.all(
                color: bgcolor, style: BorderStyle.solid, width: 1.5),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.local_hotel,
                color: bgcolor,
                size: 30,
              ),
              backgroundColor: Colors.white,
              radius: 28,
            ),
            title: Text(
              "Room No : " + roomNo.toString(),
              style: TextStyle(
                  fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Floor No : " + floorNo.toString(),
              style: TextStyle(
                  fontSize: 16, color: bgcolor, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              "Available",
              style: TextStyle(
                  fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
