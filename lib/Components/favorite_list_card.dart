import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class FavoriteListCart extends StatelessWidget {
  final Function onPress;
  final String hotelImageurl;
  final String hotelName;
  //String hotel_rating_value;

  const FavoriteListCart(
      {Key? key,
      required this.hotelImageurl,
      required this.hotelName,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onPress();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: bgcolor, style: BorderStyle.solid, width: 2.5),
              color: Color(0xFFF6F7FF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: ListTile(
            leading: Image(image: NetworkImage(hotelImageurl)),
            title: AutoSizeText(
              hotelName,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 22),
              maxLines: 1,
            ),
            subtitle: RatingBarIndicator(
              rating: 2.75,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 29.0,
              direction: Axis.horizontal,
            ),
          ),
        ));
  }
}
