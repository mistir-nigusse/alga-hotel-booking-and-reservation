import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/review.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/rooms.dart';

class About extends StatefulWidget {
  final String aboutImageUrl;
  final String aboutHotelname;
  final String aboutHoteldescription;
  final String wereda;
  final String state;
  final String city;
  final String email;
  final String phoneNo;
  final int roomTypescount;
  const About(
      {Key? key,
      required this.aboutImageUrl,
      required this.aboutHotelname,
      required this.aboutHoteldescription,
      required this.wereda,
      required this.state,
      required this.city,
      required this.email,
      required this.phoneNo,
      oneNo,
      required this.roomTypescount})
      : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Widget description() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
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
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF6F7FF),
      body: Container(
          child: DefaultTabController(
              length: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: TabBar(indicatorColor: bgcolor, tabs: [
                        Tab(
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: bgcolor,
                                fontSize: 17,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Tab(
                            child: Text("Review",
                                style: TextStyle(
                                    // backgroundColor: bgcolor,
                                    color: bgcolor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800)))
                      ]),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        description(),
                        Commentread(
                          roomTypescount: widget.roomTypescount,
                        )
                      ],
                    )),
                  ]))),
    );
  }
}
