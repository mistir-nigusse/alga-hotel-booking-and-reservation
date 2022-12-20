import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/room_type_widget.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/room_list_minified.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/map_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_room_query.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class MapDialogue extends StatefulWidget {
  final int roomTypescount;
  final String hotelName;
  final hotelindex;
  MapDialogue({
    Key? key,
    required this.roomTypescount,
    required this.hotelName,
    this.hotelindex,
  }) : super(key: key);

  @override
  _MapDialogueState createState() => _MapDialogueState();
}

class _MapDialogueState extends State<MapDialogue> {
  TextEditingController emailController = TextEditingController();

  final VariablesController variables = Get.put(VariablesController());

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: bgcolor, width: 2),
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 15,
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 1.5),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.hotelName,
                      style: TextStyle(
                          fontSize: 18,
                          color: bgcolor,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Room types",
                      style: TextStyle(
                          fontSize: 14,
                          color: bgcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Query(
                  options: QueryOptions(
                    document: gql(HotelRoomtypesQuery().hotelroomsquery),
                  ),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) {
                      if (result.exception!.linkException != null) {
                        return ErrorPage(
                          backwidget: MapPage(),
                        );
                      } else {
                        return ErrorPage2(
                          backwidget: MapPage(),
                          messagetext:
                              result.exception!.graphqlErrors[0].message,
                        );
                      }
                    }
                    variables.setHotelid(result.data?['userViewHotels']
                        [widget.roomTypescount]['Id']);
                    if (result.isLoading) {
                      return Center(
                          child: CircularProgressIndicator(color: bgcolor));
                    }
                    return ListView.builder(
                      itemCount: result
                          .data?['userViewHotels'][widget.roomTypescount]
                              ['roomTypes']
                          .length,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: InkWell(
                            onTap: () {
                              List<String> roomNos = [];

                              List<int> floorNos = [];
                              List<String> serviceNames = [];
                              List<String> roomsId = [];
                              List<int> serviceprices = [];

                              int servicePrice;
                              int roomsCount = result
                                  .data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                      [index]['rooms']
                                  .length;
                              int roomservicesCount = result
                                  .data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                      [index]['roomService']
                                  .length;
                              String roomNo;
                              String id;
                              String hotelid = result.data?['userViewHotels']
                                  [widget.roomTypescount]['Id'];
                              int floorNo;
                              String serviceName;

                              for (int z = 0; z < roomsCount; z++) {
                                roomNo = result.data?['userViewHotels']
                                        [widget.roomTypescount]['roomTypes']
                                    [index]['rooms'][z]['room_no'];
                                roomNos.add(roomNo);
                                floorNo = result.data?['userViewHotels']
                                        [widget.roomTypescount]['roomTypes']
                                    [index]['rooms'][z]['floor_no'];
                                floorNos.add(floorNo);
                                id = result.data?['userViewHotels']
                                        [widget.roomTypescount]['roomTypes']
                                    [index]['rooms'][z]['Id'];
                                roomsId.add(id);
                              }
                              variables.setroomsid(roomsId);
                              List<String> serviceIcons = [];
                              for (int z = 0; z < roomservicesCount; z++) {
                                serviceName = result.data?['userViewHotels']
                                        [widget.roomTypescount]['roomTypes']
                                    [index]['roomService'][z]['name'];
                                String serviceIcon = result
                                                .data?['userViewHotels']
                                            [widget.roomTypescount]['roomTypes']
                                        [index]['roomService'][z]['icon'] ??
                                    "";
                                serviceNames.add(serviceName);
                                serviceIcons.add(serviceIcon);
                              }
                              for (int z = 0; z < roomservicesCount; z++) {
                                servicePrice = result.data?['userViewHotels']
                                        [widget.roomTypescount]['roomTypes']
                                    [index]['roomService'][z]['price'];
                                serviceprices.add(servicePrice);
                              }
                              variables.setservicename(serviceNames);
                              variables.setserviceIcon(serviceIcons);
                              print(roomsId);
                              variables.setroomsid(roomsId);
                              variables.setservicePrice(serviceprices);
                              Navigator.pop(context);
                              Get.bottomSheet(
                                RoomlistMinified(
                                  roomscount: roomsCount,
                                  floorNo: floorNos,
                                  roomNo: roomNos,
                                  roomtypename: result.data?['userViewHotels']
                                          [widget.roomTypescount]['roomTypes']
                                      [index]['name'],
                                  hotelindex: widget.hotelindex,
                                  roomIdd: roomsId,
                                  hotelId: hotelid,
                                ),
                                isDismissible: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                              );
                            },
                            child: RoomTypeTile(
                              price: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['price'],
                              roomCapacity: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['capacity'],
                              roomtitle: result.data?['userViewHotels']
                                      [widget.roomTypescount]['roomTypes']
                                  [index]['name'],
                              degree: 20,
                            ),
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ));
  }
}
