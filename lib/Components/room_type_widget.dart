import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class RoomTypes extends StatelessWidget {
  final String roomImage;
  final String roomtitle;
  final int roomCapacity;
  final int price;
  final int roomTypescount;
  const RoomTypes(
      {Key? key,
      required this.roomImage,
      required this.roomTypescount,
      required this.roomtitle,
      required this.roomCapacity,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: MediaQuery.of(context).size.height / 2.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: bgcolor2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.5),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height / 4.30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Image.network(
                  roomImage,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: RoomTypeTile(
                degree: 0,
                price: price,
                roomCapacity: roomCapacity,
                roomtitle: roomtitle,
              ))
            ],
          ),
        ));
  }
}

class RoomTypeTile extends StatelessWidget {
  const RoomTypeTile({
    required this.roomtitle,
    required this.roomCapacity,
    required this.price,
    Key? key,
    required this.degree,
  }) : super(key: key);
  final String roomtitle;
  final int roomCapacity;
  final int price;
  final double degree;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(degree),
              topRight: Radius.circular(degree),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          minVerticalPadding: 0,
          trailing: Text(
            "$price ETB",
            style: TextStyle(
                fontSize: 18, color: bgcolor, fontWeight: FontWeight.w600),
          ),
          title: Text(
            roomtitle,
            style: TextStyle(
                fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Capacity :" + "$roomCapacity",
            style: TextStyle(
                fontSize: 17, color: bgcolor, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
