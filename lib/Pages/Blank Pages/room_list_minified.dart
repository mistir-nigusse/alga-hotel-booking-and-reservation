import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Components/reservation_form_minified.dart';
import 'package:nearby_hotel_detction_booking_app/Components/room_card.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class RoomlistMinified extends StatefulWidget {
  final floorNo;
  final roomNo;
  final int roomscount;
  final serviceName;
  final hotelId;
  final roomIdd;
  final roomtypename;
  final hotelindex;
  const RoomlistMinified(
      {Key? key,
      this.floorNo,
      this.roomNo,
      required this.roomscount,
      this.serviceName,
      this.hotelId,
      this.roomIdd,
      this.roomtypename,
      this.hotelindex})
      : super(key: key);

  @override
  _RoomlistMinifiedState createState() => _RoomlistMinifiedState();
}

List<int> items = List<int>.generate(10, (int index) => index);

class _RoomlistMinifiedState extends State<RoomlistMinified> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        border: Border.all(color: bgcolor, width: 2),
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 14,
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 1.5),
              ),
              child: Center(
                child: Column(
                  children: [
                    AutoSizeText(
                      widget.roomtypename,
                      style: TextStyle(
                          fontSize: 20,
                          color: bgcolor,
                          fontWeight: FontWeight.w600),
                    ),
                    AutoSizeText(
                      "Select the room you want to reserve",
                      style: TextStyle(
                          fontSize: 16,
                          color: bgcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.roomscount,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Roomcard(
                      roomindex: index,
                      floorNo: widget.floorNo[index],
                      roomNo: widget.roomNo[index],
                      roomStaus: "Available",
                      onpress: () {
                        Navigator.pop(context);
                        Get.bottomSheet(
                          ReserveFormMinified(
                            roomId: widget.roomIdd[index],
                            hotelId: widget.hotelId,
                            roomtypename: widget.roomtypename,
                            hotelindex: widget.hotelindex,
                            roomtypeindex: index,
                          ),
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ]),
    );
  }
}
