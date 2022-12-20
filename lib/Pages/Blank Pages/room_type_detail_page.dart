import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/room_list.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/room_type_detail.dart';

class RoomTypeDetail extends StatefulWidget {
  final String aboutImageUrl;
  final int roomcapacity;
  final price;
  final String aboutHoteldescription;
  final rating;
  final floorNo;
  final roomNo;
  final roomTypeName;
  final int roomtypeindex;
  final int count;
  const RoomTypeDetail(
      {Key? key,
      required this.aboutImageUrl,
      required this.price,
      required this.aboutHoteldescription,
      required this.rating,
      required this.floorNo,
      required this.roomNo,
      required this.roomTypeName,
      required this.roomtypeindex,
      required this.count,
      required this.roomcapacity})
      : super(key: key);

  @override
  _RoomTypeDetailState createState() => _RoomTypeDetailState();
}

class _RoomTypeDetailState extends State<RoomTypeDetail> {
  String image =
      'https://media.istockphoto.com/photos/3d-rendering-beautiful-luxury-bedroom-suite-in-hotel-with-tv-picture-id1066999762?k=6&m=1066999762&s=612x612&w=0&h=SQ2803yCqKwHiSrqJPVOU-DJwaYswbI2wDq3Z-dV5DA=';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F7FF),
        body: new NestedScrollView(
          headerSliverBuilder: (_, __) => <Widget>[
            new SliverAppBar(
                backgroundColor: Color(0xFFF6F7FF),
                toolbarHeight: MediaQuery.of(context).size.height / 15,
                expandedHeight: MediaQuery.of(context).size.height / 1.6,
                floating: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(Icons.chevron_left, color: bgcolor2, size: 35),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                pinned: true,
                snap: false,
                elevation: 0.0,
                // backgroundColor: Colors.transparent,
                flexibleSpace: new BackgroundFlexibleSpaceBar(
                  // title: AutoSizeText(
                  //   widget.roomTypeName,
                  //   style: TextStyle(
                  //     color: bgcolor,
                  //     fontSize: 23.0,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  titlePadding: const EdgeInsets.only(left: 45.0, bottom: 12.0),
                  background: Details(
                    price: widget.price,
                    aboutHoteldescription: widget.aboutHoteldescription,
                    aboutImageUrl: widget.aboutImageUrl,
                    rating: widget.rating,
                    roomTypeindex: widget.roomtypeindex,
                    roomCapacity: widget.roomcapacity,
                  ),
                ))
          ],
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SafeArea(
              child: RoomsList(
                  price: widget.price,
                  floorNo: widget.floorNo,
                  roomNo: widget.roomNo,
                  roomscount: widget.count),
            ),
          ),
        )

        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //   child: DefaultTabController(
        //     length: 2,
        //     child: Column(
        //       children: [
        //         Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.only(
        //                 topLeft: Radius.circular(10.0),
        //                 topRight: Radius.circular(10.0),
        //                 bottomLeft: Radius.circular(10.0),
        //                 bottomRight: Radius.circular(10.0)),
        //             border: Border.all(
        //                 color: bgcolor, style: BorderStyle.solid, width: 2.5),
        //           ),
        //           child: TabBar(
        //             indicatorColor: Colors.redAccent,
        //             unselectedLabelColor: Color(0xFF555555),
        //             labelColor: bgcolor,
        //             labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
        //             tabs: [
        //               Tab(
        //                 child: Text(
        //                   "Detail",
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //               ),
        //               Tab(
        //                 child: Text(
        //                   "Rooms",
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         Expanded(
        //           child: Container(
        //             height: MediaQuery.of(context).size.height,
        //             child: TabBarView(
        //               children: [
        //                 //Now let's create our first tab page
        //                 Details(
        //                   price: widget.price,
        //                   aboutHoteldescription: widget.aboutHoteldescription,
        //                   aboutImageUrl: image,
        //                   rating: widget.rating,
        //                   roomTypeindex: widget.roomtypeindex,
        //                   roomCapacity: widget.roomcapacity,
        //                 ),
        //                 RoomsList(
        //                     floorNo: widget.floorNo,
        //                     roomNo: widget.roomNo,
        //                     roomscount: widget.count),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
