import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/map_dealogue.dart';
//import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/map_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_room_query.dart';

//

class SearchHotels extends SearchDelegate<String> {
  List<String> hotelnames = [];

  SearchHotels(
    this.hotelnames,
  );

  final VariablesController variableController = Get.put(VariablesController());
  final searchhistorystorage = GetStorage();
  final VariablesController variables = Get.put(VariablesController());
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> hotelslist = query.isEmpty
        ? variableController.history
        : hotelnames.where((P) => P.contains(query)).toList();
    return hotelnames.contains(query)
        ? ListView.builder(
            itemCount: hotelslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: InkWell(
                  onTap: () {
                    String searchedHotel = query.isEmpty
                        ? variableController.gethistory()[index]
                        : hotelnames
                            .where((P) => P.contains(query))
                            .toList()[index];
                    variableController.history.contains(searchedHotel)
                        ? ''
                        : variableController.sethistory(searchedHotel);

                    int hotelindex = hotelnames.indexOf(searchedHotel);

                    Get.bottomSheet(Query(
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
                          variables.setHotelid(
                              result.data?['userViewHotels'][hotelindex]['Id']);
                          if (result.isLoading) {
                            return Center(
                                child:
                                    CircularProgressIndicator(color: bgcolor));
                          }
                          List<String> roomNos = [];

                          List<int> floorNos = [];
                          List<String> serviceNames = [];
                          List<String> roomsId = [];
                          List<int> serviceprices = [];
                          List<String> roomtypsname = [];
                          String roomNo;
                          String id;

                          int floorNo;
                          int servicePrice;
                          String serviceName;
                          int roomstypscount = result
                              .data?['userViewHotels'][hotelindex]['roomTypes']
                              .length;
                          int roomsCount = result
                              .data?['userViewHotels'][hotelindex]['roomTypes']
                                  [index]['rooms']
                              .length;
                          int roomservicesCount = result
                              .data?['userViewHotels'][hotelindex]['roomTypes']
                                  [index]['roomService']
                              .length;
                          String idd =
                              result.data?['userViewHotels'][hotelindex]['Id'];
                          for (int z = 0; z < roomsCount; z++) {
                            roomNo = result.data?['userViewHotels'][hotelindex]
                                ['roomTypes'][index]['rooms'][z]['room_no'];
                            roomNos.add(roomNo);
                            floorNo = result.data?['userViewHotels'][hotelindex]
                                ['roomTypes'][index]['rooms'][z]['floor_no'];
                            floorNos.add(floorNo);
                            variables.setroomsno(roomNos);
                            variables.setfloorno(floorNos);
                            id = result.data?['userViewHotels'][hotelindex]
                                ['roomTypes'][index]['rooms'][z]['Id'];
                            roomsId.add(id);
                          }
                          List<String> serviceIcons = [];
                          for (int z = 0; z < roomservicesCount; z++) {
                            serviceName = result.data?['userViewHotels']
                                    [hotelindex]['roomTypes'][index]
                                ['roomService'][z]['name'];
                            serviceNames.add(serviceName);
                            String serviceIcon = result.data?['userViewHotels']
                                    [hotelindex]['roomTypes'][index]
                                ['roomService'][z]['icon'];
                            serviceNames.add(serviceName);
                            serviceIcons.add(serviceIcon);
                          }

                          for (int z = 0; z < roomservicesCount; z++) {
                            servicePrice = result.data?['userViewHotels']
                                    [hotelindex]['roomTypes'][index]
                                ['roomService'][z]['price'];
                            serviceprices.add(servicePrice);
                          }
                          for (int r = 0; r < roomstypscount; r++) {
                            String name = result.data?['userViewHotels']
                                [hotelindex]['roomTypes'][index]['name'];
                            roomtypsname.add(name);
                          }
                          variables.setserviceIcon(serviceIcons);
                          variables.setservicename(serviceNames);
                          variables.setservicePrice(serviceprices);

                          variables.setHotelid(idd);

                          variables.setroomsid(roomsId);

                          return MapDialogue(
                              hotelindex: hotelindex,
                              roomTypescount: hotelindex,
                              hotelName: hotelnames
                                  .where((P) => P.contains(query))
                                  .toList()[index]);
                        }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: bgcolor, width: 4),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(hotelslist[index]),
                      subtitle: RatingBarIndicator(
                        rating: 4.2,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 30.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
              );
            })
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('No Hotels found'),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> hotelslist = query.isEmpty
        ? variableController.history
        : hotelnames.where((P) => P.contains(query)).toList();

    return hotelslist.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('No Hotels found'),
          )
        : ListView.builder(
            itemCount: hotelslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: InkWell(
                  onTap: () {
                    String searchedHotel = query.isEmpty
                        ? variableController.gethistory()[index]
                        : hotelnames
                            .where((P) => P.contains(query))
                            .toList()[index];
                    variableController.history.contains(searchedHotel)
                        ? ''
                        : variableController.sethistory(searchedHotel);

                    int hotelindex = hotelnames.indexOf(searchedHotel);

                    Get.bottomSheet(Query(
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
                          variables.setHotelid(
                              result.data?['userViewHotels'][hotelindex]['Id']);
                          if (result.isLoading) {
                            return Center(
                                child:
                                    CircularProgressIndicator(color: bgcolor));
                          }
                          List<String> roomNos = [];

                          List<int> floorNos = [];
                          List<String> serviceNames = [];
                          List<String> roomsId = [];
                          List<int> serviceprices = [];

                          String roomNo;
                          String id;

                          int floorNo;
                          int servicePrice;
                          String serviceName;
                          int roomsCount = result
                              .data?['userViewHotels'][hotelindex]['roomTypes']
                                  [index]['rooms']
                              .length;
                          int roomservicesCount = result
                              .data?['userViewHotels'][hotelindex]['roomTypes']
                                  [index]['roomService']
                              .length;
                          String idd =
                              result.data?['userViewHotels'][hotelindex]['Id'];
                          for (int z = 0; z < roomsCount; z++) {
                            roomNo = result.data?['userViewHotels'][hotelindex]
                                ['roomTypes'][index]['rooms'][z]['room_no'];
                            roomNos.add(roomNo);
                            floorNo = result.data?['userViewHotels'][hotelindex]
                                ['roomTypes'][index]['rooms'][z]['floor_no'];
                            floorNos.add(floorNo);
                            variables.setroomsno(roomNos);
                            variables.setfloorno(floorNos);
                            id = result.data?['userViewHotels'][hotelindex]
                                ['roomTypes'][index]['rooms'][z]['Id'];
                            roomsId.add(id);
                          }
                          List<String> serviceIcons = [];
                          for (int z = 0; z < roomservicesCount; z++) {
                            serviceName = result.data?['userViewHotels']
                                    [hotelindex]['roomTypes'][index]
                                ['roomService'][z]['name'];
                            String serviceIcon = result.data?['userViewHotels']
                                        [hotelindex]['roomTypes'][index]
                                    ['roomService'][z]['icon'] ??
                                "";
                            serviceNames.add(serviceName);
                            serviceIcons.add(serviceIcon);
                          }

                          for (int z = 0; z < roomservicesCount; z++) {
                            servicePrice = result.data?['userViewHotels']
                                    [hotelindex]['roomTypes'][index]
                                ['roomService'][z]['price'];
                            serviceprices.add(servicePrice);
                          }

                          variables.setservicename(serviceNames);
                          variables.setservicePrice(serviceprices);
                          variables.setserviceIcon(serviceIcons);
                          variables.setHotelid(idd);

                          variables.setroomsid(roomsId);

                          return MapDialogue(
                              hotelindex: hotelindex,
                              roomTypescount: hotelindex,
                              hotelName: hotelnames
                                  .where((P) => P.contains(query))
                                  .toList()[index]);
                        }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: bgcolor, width: 4),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(hotelslist[index]),
                      subtitle: RatingBarIndicator(
                        rating: 4.2,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 30.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
