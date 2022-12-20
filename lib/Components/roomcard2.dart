import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/bookin_page_controller.dart';

class RoomCard2 extends StatefulWidget {
  final floorNo;
  final roomindex;
  final roomNo;
  final roomStaus;
  final price;
  var selectedRoomList;
  RoomCard2({
    Key? key,
    required this.selectedRoomList,
    required this.floorNo,
    required this.roomNo,
    required this.roomStaus,
    required this.price,
    this.roomindex,
  }) : super(key: key);

  @override
  State<RoomCard2> createState() => _RoomCard2State();
}

class _RoomCard2State extends State<RoomCard2> {
  @override
  Widget build(BuildContext context) {
    var room = [];
    bool isChanged = false;

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Container(
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
          child: CheckboxListTile(
              checkColor: Colors.white,
              value: isChanged,
              selected: isChanged,
              activeColor: bgcolor,
              onChanged: (bool? value) {
                setState(() {
                  isChanged = value!;
                  if (isChanged == true) {
                    room.add(widget.floorNo);
                    room.add(widget.price);
                    room.add(widget.roomStaus);
                    room.add(widget.roomNo);
                    room.add(widget.roomindex);
                    widget.selectedRoomList.add(room);
                    //print(widget.selectedRoomList);
                  } else {
                    widget.selectedRoomList.remove(room);
                  }
                });
              },
              title: Text(
                "Room No : " + widget.roomNo.toString(),
                style: TextStyle(
                    fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Floor No : " + widget.floorNo.toString(),
                style: TextStyle(
                    fontSize: 16, color: bgcolor, fontWeight: FontWeight.w600),
              ),
              secondary: Text(
                "Available",
                style: TextStyle(
                    fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity.leading),
        );
      },
    );
  }
}
