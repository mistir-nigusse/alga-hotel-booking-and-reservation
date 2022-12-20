import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class GalleryCard extends StatelessWidget {
  //final Function press;
  final urls;
  final index;
  const GalleryCard({
    Key? key,
    //   required this.press,
    this.urls,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: bgcolor2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.network(
          urls[index],
          height: 150,
        ),
      ),
    );
  }
}
