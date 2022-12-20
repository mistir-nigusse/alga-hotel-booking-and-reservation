import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/date_selector.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/reservation_dialogue.dart';
import 'package:nearby_hotel_detction_booking_app/Components/room_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/roomcard2.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/bookin_page_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Components/services.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/bookin_page_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/user_data.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/Reservation_mutation.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/reservation_form_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank Pages/reserve_now_form.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/reserve_multiple.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/reserve_now_form.dart';

import '../rooms.dart';

class RoomsList extends StatefulWidget {
  final floorNo;
  final roomNo;
  final int roomscount;
  final serviceName;
  final hotelId;
  final roomIdd;
  final price;
  const RoomsList(
      {Key? key,
      this.floorNo,
      this.roomNo,
      required this.roomscount,
      this.serviceName,
      this.hotelId,
      this.roomIdd,
      required this.price})
      : super(key: key);

  @override
  _RoomsListState createState() => _RoomsListState();
}

final VariablesController variableController = Get.put(VariablesController());

class _RoomsListState extends State<RoomsList> {
  Widget ReserveSingle() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 5, top: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Room List",
            style: TextStyle(
                fontSize: 16, color: bgcolor, fontWeight: FontWeight.w600),
          ),
          Text(
            "Select the room you want to reserve. ",
            style: TextStyle(
                fontSize: 12, color: bgcolor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.roomscount,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (BuildContext context, int index) {
                return Roomcard(
                  onpress: () {
                    Navigator.push(
                        context,
                        FadePageRoute(
                            widget: ReserveForm(
                          price: widget.price,
                          roomindex: index,
                          roomno: widget.roomNo[index],
                          floorno: widget.floorNo[index],
                        )));
                  },
                  // roomindex: index,
                  floorNo: widget.floorNo[index],
                  roomNo: widget.roomNo[index],
                  roomStaus: "Available",
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget ReserveMultiple() {
    dynamic selectedRoomList = List<dynamic>.empty(growable: true);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 5, top: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Room List",
            style: TextStyle(
                fontSize: 16, color: bgcolor, fontWeight: FontWeight.w600),
          ),
          Text(
            "Select the room you want to reserve. ",
            style: TextStyle(
                fontSize: 12, color: bgcolor, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.roomscount,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    RoomCard2(
                      selectedRoomList: selectedRoomList,
                      price: widget.price,
                      roomindex: index,
                      floorNo: widget.floorNo[index],
                      roomNo: widget.roomNo[index],
                      roomStaus: "Available",
                    ),
                  ],
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              color: bgcolor,
              child: TextButton(
                  onPressed: () {
                    print(selectedRoomList);
                    Navigator.push(
                        context,
                        FadePageRoute(
                            widget: ReserveMultipleForm(
                                selectedRoomList: selectedRoomList)));
                  },
                  child: Text("continue to reservation ",
                      style: TextStyle(color: bgcolor2))),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HttpLink httpLink = HttpLink(
      'http://157.230.190.157/graphql',
      defaultHeaders: <String, String>{
        'Authorization': 'Bearer ${variables.getoken()}',
      },
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        body: Container(
            child: DefaultTabController(
                length: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: TabBar(tabs: [
                          Tab(
                            child: Text(
                              "Single reservation",
                              style: TextStyle(
                                  color: bgcolor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                              child: Text("For a company",
                                  style: TextStyle(
                                      // backgroundColor: bgcolor,
                                      color: bgcolor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)))
                        ]),
                      ),
                      Expanded(
                          child: TabBarView(
                        children: [ReserveSingle(), ReserveMultiple()],
                      )),
                    ]))),
      ),
    );
  }
}
