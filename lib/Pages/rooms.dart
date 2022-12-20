import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/room_type_widget.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_list.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_room_query.dart';

import 'Blank Pages/room_type_detail_page.dart';

class Rooms extends StatefulWidget {
  final int roomTypescount;
  Rooms({Key? key, required this.roomTypescount}) : super(key: key);
  final VariablesController variables = Get.put(VariablesController());
  @override
  _RoomsState createState() => _RoomsState();
}

List<int> items = List<int>.generate(10, (int index) => index);
final VariablesController variables = Get.put(VariablesController());

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        elevation: 0.0,
        backgroundColor: Color(0xFFF6F7FF),
        title: Text(
          "Room Catagories",
          style: TextStyle(
              fontSize: 20, color: bgcolor, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: bgcolor, size: 35),
          onPressed: () {
            Get.back();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: Query(
          options: QueryOptions(
            document: gql(HotelRoomtypesQuery().hotelroomsquery),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              if (result.exception!.linkException != null) {
                return ErrorPage(
                  backwidget: Hotels(),
                );
              } else {
                return ErrorPage2(
                  backwidget: Hotels(),
                  messagetext: result.exception!.graphqlErrors[0].message,
                );
              }
            }
            variables.setHotelid(
                result.data?['userViewHotels'][widget.roomTypescount]['Id']);
            if (result.isLoading) {
              return Center(child: CircularProgressIndicator(color: bgcolor));
            }

            return Container(
              color: bgcolor2,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: result
                    .data?['userViewHotels'][widget.roomTypescount]['roomTypes']
                    .length,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      List<String> roomNos = [];

                      List<int> floorNos = [];
                      List<String> serviceNames = [];
                      List<String> roomsId = [];
                      List<int> serviceprices = [];
                      int servicePrice;
                      int roomsCount = result
                          .data?['userViewHotels'][widget.roomTypescount]
                              ['roomTypes'][index]['rooms']
                          .length;
                      int roomservicesCount = result
                          .data?['userViewHotels'][widget.roomTypescount]
                              ['roomTypes'][index]['roomService']
                          .length;
                      String roomNo;
                      String id;

                      int floorNo;
                      String serviceName;

                      for (int z = 0; z < roomsCount; z++) {
                        roomNo = result.data?['userViewHotels']
                                [widget.roomTypescount]['roomTypes'][index]
                            ['rooms'][z]['room_no'];
                        roomNos.add(roomNo);
                        floorNo = result.data?['userViewHotels']
                                [widget.roomTypescount]['roomTypes'][index]
                            ['rooms'][z]['floor_no'];
                        floorNos.add(floorNo);
                        id = result.data?['userViewHotels']
                                [widget.roomTypescount]['roomTypes'][index]
                            ['rooms'][z]['Id'];
                        roomsId.add(id);
                      }
                      variables.setroomsid(roomsId);
                      List<String> serviceIcons = [];
                      for (int z = 0; z < roomservicesCount; z++) {
                        serviceName = result.data?['userViewHotels']
                                [widget.roomTypescount]['roomTypes'][index]
                            ['roomService'][z]['name'];
                        String serviceIcon = result.data?['userViewHotels']
                                    [widget.roomTypescount]['roomTypes'][index]
                                ['roomService'][z]['icon'] ??
                            "";
                        serviceNames.add(serviceName);
                        serviceIcons.add(serviceIcon);
                      }

                      for (int z = 0; z < roomservicesCount; z++) {
                        servicePrice = result.data?['userViewHotels']
                                [widget.roomTypescount]['roomTypes'][index]
                            ['roomService'][z]['price'];
                        serviceprices.add(servicePrice);
                      }
                      variables.setservicename(serviceNames);
                      variables.setserviceIcon(serviceIcons);
                      print(roomsId);
                      variables.setroomsid(roomsId);
                      variables.setservicePrice(serviceprices);
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            FadePageRoute(
                                widget: RoomTypeDetail(
                              roomTypeName: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['name'],
                              aboutHoteldescription:
                                  result.data?['userViewHotels']
                                          [widget.roomTypescount]['roomTypes']
                                      [index]['description'],
                              price: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['price'],
                              roomNo: roomNos,
                              rating: 5,
                              floorNo: floorNos,
                              aboutImageUrl: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['images'][0]["imageURI"],
                              roomtypeindex: index,
                              count: roomsCount,
                              roomcapacity: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['capacity'],
                            )));
                      });
                    },
                    child: RoomTypes(
                      roomImage: result.data?['userViewHotels']
                              [widget.roomTypescount]['roomTypes'][index]
                          ['images'][0]["imageURI"],
                      roomTypescount: widget.roomTypescount,
                      price: result.data?['userViewHotels']
                          [widget.roomTypescount]['roomTypes'][index]['price'],
                      roomCapacity: result.data?['userViewHotels']
                              [widget.roomTypescount]['roomTypes'][index]
                          ['capacity'],
                      roomtitle: result.data?['userViewHotels']
                          [widget.roomTypescount]['roomTypes'][index]['name'],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
