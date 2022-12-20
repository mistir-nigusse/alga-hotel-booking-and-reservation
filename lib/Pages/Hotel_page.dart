import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/about.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/gallery.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/review.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/rooms.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/gallery_query.dart';

class TravelApp extends StatefulWidget {
  final String aboutImageUrl;
  final String aboutHotelname;
  final String aboutHoteldescription;
  final String wereda;
  final String state;
  final String city;
  final String email;
  final String phoneNo;
  final String hotelImageurl;
  final rating;
  final ratetotal;
  final hotelName;

  final id;
  final int roomTypescount;

  const TravelApp(
      {Key? key,
      required this.aboutImageUrl,
      required this.aboutHotelname,
      required this.aboutHoteldescription,
      required this.wereda,
      required this.state,
      required this.city,
      required this.email,
      required this.phoneNo,
      required this.hotelImageurl,
      required this.hotelName,
      required this.roomTypescount,
      this.id,
      this.rating,
      this.ratetotal})
      : super(key: key);
  @override
  _TravelAppState createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F7FF),
        appBar: AppBar(
          title: Text("About",
              style: TextStyle(
                  fontSize: 22, color: bgcolor, fontWeight: FontWeight.w500)),
          toolbarHeight: MediaQuery.of(context).size.height / 13,
          elevation: 0.0,
          backgroundColor: Color(0xFFF6F7FF),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: bgcolor, size: 35),
            onPressed: () {
              Get.back();
            },
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                //  CarouselSlider.builder(itemCount: itemCount, itemBuilder: itemBuilder, options: options),
                Container(
                  padding: EdgeInsets.all(4),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    border: Border.all(
                        color: bgcolor, style: BorderStyle.solid, width: 0.5),
                  ),
                  child: Gallery(roomTypescount: widget.roomTypescount),
                  /* ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: Image.network(
                      widget.aboutImageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),*/
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.9,
                            child: Text(widget.aboutHotelname,
                                style: TextStyle(
                                    fontSize: 27,
                                    color: bgcolor,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          TextButton(
                              onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Rooms(
                                          roomTypescount: widget.roomTypescount,
                                        ),
                                      ),
                                    )
                                  },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0XFF318972))),
                              child: AutoSizeText(
                                "Book now",
                                style: TextStyle(color: bgcolor2, fontSize: 20),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.state +
                            ', ' +
                            widget.city +
                            ', ' +
                            widget.wereda +
                            ', ',
                        style: TextStyle(
                            fontSize: 15,
                            color: bgcolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.call, color: bgcolor),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.phoneNo,
                        style: TextStyle(
                            fontSize: 18,
                            color: bgcolor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: About(
                    aboutHoteldescription: widget.aboutHoteldescription,
                    aboutHotelname: widget.aboutHotelname,
                    aboutImageUrl: widget.aboutImageUrl,
                    city: widget.city,
                    email: widget.email,
                    phoneNo: widget.phoneNo,
                    wereda: widget.wereda,
                    state: widget.state,
                    roomTypescount: widget.roomTypescount,
                  ),
                ),

                /*   Expanded(
                  child: Commentread(
                    roomTypescount: widget.roomTypescount,
                  ),
                ),
                 */
              ],
            ),
          ),
        ));
  }
}
