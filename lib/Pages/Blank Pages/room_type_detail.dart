// ignore_for_file: unused_import

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Components/services.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/room_list.dart';

class Details extends StatefulWidget {
  final String aboutImageUrl;
  final int roomCapacity;
  final price;
  final String aboutHoteldescription;
  final rating;
  final int roomTypeindex;
  const Details(
      {Key? key,
      required this.aboutImageUrl,
      this.price,
      required this.aboutHoteldescription,
      required this.rating,
      required this.roomTypeindex,
      required this.roomCapacity})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final VariablesController variableController = Get.put(VariablesController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(
                    color: bgcolor, style: BorderStyle.solid, width: 2.5),
              ),
              child: Image.network(
                widget.aboutImageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.price.toString() + ' birr/Night',
                    style: TextStyle(
                        fontSize: 23,
                        color: bgcolor,
                        fontWeight: FontWeight.w600),
                  ),
                  AutoSizeText(
                    "Capacity: " + widget.roomCapacity.toString() + " Adults",
                    style: TextStyle(
                        fontSize: 23,
                        color: bgcolor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingBar.builder(
                    itemSize: 28,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),

            /** 
            Container(
                height: MediaQuery.of(context).size.height / 9,
                // padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: variableController.serviceIcon.length,
                    itemBuilder: (context, index) {
                      return ServicesCard(
                        serviceIcon:
                            variableController.serviceIcon[index].toString(),
                        servicesname: variableController.servicesName[index],
                      );
                    })),
   */
            Divider(
              color: bgcolor,
              indent: 4,
              endIndent: 4,
              thickness: 2,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  widget.aboutHoteldescription,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    color: bgcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
