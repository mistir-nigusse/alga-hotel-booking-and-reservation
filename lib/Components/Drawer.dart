import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/main_layout3.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/Aboutus.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/help.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/history.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/homepage.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/settings.dart';

class Mydrawer extends StatefulWidget {
  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  final VariablesController variableController = Get.put(VariablesController());
  @override
  Widget build(BuildContext context) {
    double padd = MediaQuery.of(context).size.width / 5;
    double paddingttop = MediaQuery.of(context).size.height / 12;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(10)),
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                Container(
                  child: ClipPath(
                    clipper: MyClipper2(),
                    child: Container(
                      color: bgcolor,
                      height: MediaQuery.of(context).size.height / 3.8,
                      // width: MediaQuery.of(context).size.width / 1.5,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 35, bottom: paddingttop),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: bgcolor,
                        ),
                      ),
                    ),
                    Divider(
                      color: bgcolor,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.home_outlined,
                              size: 28,
                              color: bgcolor,
                            ),
                            title: Text("Home"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  FadePageRoute(
                                      widget: Homepage(
                                    token: variableController.getoken(),
                                  )));
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.list_number_rtl,
                              size: 28,
                              color: bgcolor,
                            ),
                            title: Text("Reserved/Booked"),
                            onTap: () {
                              Navigator.push(
                                  context, FadePageRoute(widget: History()));
                            },
                          ),
                          ListTile(
                              leading: Icon(
                                CupertinoIcons.settings,
                                size: 28,
                                color: bgcolor,
                              ),
                              title: Text("Settings"),
                              onTap: () {
                                Navigator.push(
                                    context, FadePageRoute(widget: Settings()));
                              }),
                          ListTile(
                              leading: Icon(
                                CupertinoIcons.archivebox,
                                size: 28,
                                color: bgcolor,
                              ),
                              title: Text("History"),
                              onTap: () {
                                //Todo: history page
                                Navigator.push(
                                    context, FadePageRoute(widget: Help()));
                              }),
                          ListTile(
                              leading: Icon(
                                CupertinoIcons.question_circle,
                                size: 28,
                                color: bgcolor,
                              ),
                              title: Text("Help"),
                              onTap: () {
                                Navigator.push(
                                    context, FadePageRoute(widget: Help()));
                              }),
                          ListTile(
                              leading: Icon(
                                CupertinoIcons.info,
                                size: 28,
                                color: bgcolor,
                              ),
                              title: Text("About Us"),
                              onTap: () {
                                Navigator.push(
                                    context, FadePageRoute(widget: Aboutus()));
                              }),
                          ListTile(
                              leading: Icon(
                                CupertinoIcons.globe,
                                size: 28,
                                color: bgcolor,
                              ),
                              title: Text("Language"),
                              onTap: () {
                                Navigator.push(
                                    context, FadePageRoute(widget: Help()));
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      color: bgcolor,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0, left: padd),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.copyright,
                          color: bgcolor,
                        ),
                        Text(
                          "  RCNDC.com",
                          style: TextStyle(color: bgcolor),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
