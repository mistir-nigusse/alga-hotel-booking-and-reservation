import 'package:auto_size_text/auto_size_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/favorite_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

// ignore: must_be_immutable
class HotelListCart extends StatelessWidget {
  HotelListCart(
      {Key? key,
      required this.onpress,
      required this.hotelImageUrl,
      required this.hotelname,
      required this.index,
      required this.star,
      required this.address})
      : super(key: key);
  final Function onpress;

  final String hotelImageUrl, hotelname, address;
  int star;
  final int index;
  Fav favcont = Get.put(Fav());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return InkWell(
      highlightColor: Colors.green,
      onTap: () {
        onpress();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
            width: size.width,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color(0xFFF6F7FF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: size.height * 0.128,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(hotelImageUrl),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            hotelname.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontSize: 18),
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.006,
                        ),
                        RatingBarIndicator(
                          rating: 2.75,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.green[800],
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        AutoSizeText(
                          address,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 8,
                  top: 30,
                  child: FavoriteButton(
                      isFavorite: false,
                      iconSize: 45,
                      iconColor: bgcolor,
                      valueChanged: (_isFavorite) {
                        if (!favcont.getName().contains(hotelname)) {
                          favcont.setHotelNames(hotelname);
                          favcont.setHotelNurl(hotelImageUrl);
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
                          Get.snackbar(
                              "Warning", "This hotel is already your favorite",
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
                )
              ],
            )),
      ),
    );
  }
}

class HotelListCart2 extends StatelessWidget {
  HotelListCart2(
      {Key? key,
      required this.onpress,
      required this.hotelImageUrl,
      required this.hotelname,
      required this.index,
      required this.star,
      required this.address})
      : super(key: key);
  final Function onpress;

  final String hotelImageUrl, hotelname, address;
  int star;
  final int index;
  Fav favcont = Get.put(Fav());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return InkWell(
      highlightColor: Colors.green,
      onTap: () {
        onpress();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
            width: size.width,
            height: size.height / 3.5,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            decoration: BoxDecoration(
                color: Color(0xFFF6F7FF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(color: bgcolor),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              children: [
                Container(
                  //4.1
                  height: size.height / 4,
                  width: size.width / 2.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        image: NetworkImage(hotelImageUrl), fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 30, 5, 5),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: size.height / 6,
                    width: size.width / 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          hotelname.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: bgcolor,
                              fontSize: 15),
                          maxLines: 1,
                        ),
                        // SizedBox(
                        //     // height: size.height * 0.006,
                        //     ),
                        RatingBarIndicator(
                          rating: 2.75,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),

                        AutoSizeText(
                          address,
                          style: TextStyle(
                            // backgroundColor: Color.fromARGB(221, 71, 69, 69),
                            color: Color.fromARGB(255, 77, 75, 75),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: FavoriteButton(
                              isFavorite: false,
                              iconSize: 40,
                              iconColor: Color.fromARGB(255, 240, 22, 7),
                              valueChanged: (_isFavorite) {
                                if (!favcont.getName().contains(hotelname)) {
                                  favcont.setHotelNames(hotelname);
                                  favcont.setHotelNurl(hotelImageUrl);
                                  Get.snackbar(
                                      "Success", "Hotel added as favorite",
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: bgcolor,
                                      backgroundColor: Colors.white,
                                      borderColor: bgcolor,
                                      duration: Duration(seconds: 1),
                                      animationDuration: Duration(seconds: 1),
                                      borderRadius: 15,
                                      borderWidth: 2.5);
                                } else {
                                  Get.snackbar("Warning",
                                      "This hotel is already your favorite",
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
