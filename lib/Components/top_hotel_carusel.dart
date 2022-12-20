import 'package:auto_size_text/auto_size_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/favorite_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class TopHotelsCarusel extends StatefulWidget {
  final String hotelImageUrl, hotelname, price;
  const TopHotelsCarusel(
      {Key? key,
      required this.hotelImageUrl,
      required this.hotelname,
      required this.price})
      : super(key: key);

  @override
  _TopHotelsCaruselState createState() => _TopHotelsCaruselState();
}

class _TopHotelsCaruselState extends State<TopHotelsCarusel> {
  Fav favcont = Get.put(Fav());
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(2),
        height: MediaQuery.of(context).size.height / 4.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: bgcolor2,
          boxShadow: [
            BoxShadow(
              color: bgcolor.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 9,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          border:
              Border.all(color: bgcolor, style: BorderStyle.solid, width: 0.5),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: Image.network(
                widget.hotelImageUrl,
                height: MediaQuery.of(context).size.height / 7.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(widget.hotelname,
                      style: TextStyle(fontSize: 17)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBarIndicator(
                        rating: 4.5,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: bgcolor,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(widget.price,
                              style: TextStyle(fontSize: 14)),
                          AutoSizeText(
                            "/Night",
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        child: CircleAvatar(
          backgroundColor: bgcolor2,
          radius: 17,
          child: FavoriteButton(
              isFavorite: false,
              iconSize: 36,
              iconColor: bgcolor,
              valueChanged: (_isFavorite) {
                if (!favcont.getName().contains(widget.hotelname)) {
                  favcont.setHotelNames(widget.hotelname);
                  favcont.setHotelNurl(widget.hotelImageUrl);
                  Get.snackbar("Success", "Hotel added as favorite",
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: bgcolor,
                      backgroundColor: Colors.white,
                      borderColor: bgcolor,
                      duration: Duration(seconds: 1),
                      animationDuration: Duration(seconds: 1),
                      borderRadius: 15,
                      borderWidth: 2.5);
                } else {
                  Get.snackbar("Warning", "This hotel is already your favorite",
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: bgcolor,
                      backgroundColor: Colors.white,
                      borderColor: bgcolor,
                      duration: Duration(seconds: 1),
                      animationDuration: Duration(seconds: 1),
                      borderRadius: 15,
                      borderWidth: 2.5);
                }
                print('object');
              }),
        ),
        top: 8,
        right: 10,
      ),
    ]);
  }
}
