import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/map_componenet.dart';
import 'package:nearby_hotel_detction_booking_app/Components/search_delegates.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_query.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final VariablesController variables = Get.put(VariablesController());
  List<LatLng> hotelsPosition = [];
  late int length1 = 0;
  bool x = false;
  List<String?> hotelsname = [];
  List<String> hotelimageurl = [];
  List<int> hotelstar = [];
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(AllHotelQuery().allhotelquery),
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
                messagetext: result.exception!.graphqlErrors[0].message,
              );
            }
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator(color: bgcolor));
          }
          List<String> hotelnames = [];
          int hotelsCount;
          hotelsCount = result.data?['userViewHotels'].length;

          for (int x = 0; x < hotelsCount; x++) {
            String hotelname = result.data?['userViewHotels'][x]['name'];
            hotelnames.add(hotelname);
          }

          hotelnames = hotelnames.map((name) => name.toLowerCase()).toList();
          List<String> hotelNames = [];
          List<String> hoteldescripions = [];
          List<String> cities = [];
          List<String> weredas = [];
          List<String> states = [];
          List<String> phonenos = [];
          List<String> hotelIds = [];
          List<String> email = [];
          List<String> hotelImageUrls = [];
          int hotelcount = result.data?['userViewHotels'].length;
          for (int i = 0; i < hotelcount; i++) {
            String name = result.data?['userViewHotels'][i]['name'];
            hotelNames.add(name);
            String desc = result.data?['userViewHotels'][i]['description'];
            hoteldescripions.add(desc);
            String city = result.data?['userViewHotels'][i]['location']['city'];
            cities.add(city);
            String wereda =
                result.data?['userViewHotels'][i]['location']['wereda'];
            weredas.add(wereda);
            String state =
                result.data?['userViewHotels'][i]['location']['state'];
            states.add(state);
            String phno =
                result.data!['userViewHotels'][i]['phone_no'].toString();
            phonenos.add(phno);
            String id = result.data?['userViewHotels'][i]['Id'];
            hotelIds.add(id);
            String url =
                result.data?['userViewHotels'][i]['photos'][0]['imageURI'];
            hotelImageUrls.add(url);
            String emails = result.data?['userViewHotels'][i]['email'];
            email.add(emails);
          }

          return Scaffold(
            drawer: Mydrawer(),
            body: Stack(children: [
              MapPagecontent(
                  showposiononlist: () {
                    setState(() {
                      x = true;
                    });
                  },
                  aboutHoteldescription: hoteldescripions,
                  aboutHotelname: hotelNames,
                  city: cities,
                  wereda: weredas,
                  state: states,
                  email: email,
                  phoneNo: phonenos,
                  aboutImageUrl: '',
                  id: hotelIds,
                  hotelImageurl: hotelImageUrls),
              SafeArea(
                child: Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Builder(
                              builder: (con) => Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: IconButton(
                                      icon: Icon(
                                        CupertinoIcons.list_dash,
                                        color: bgcolor,
                                        size: 32,
                                      ),
                                      onPressed: () =>
                                          Scaffold.of(con).openDrawer(),
                                    ),
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: IconButton(
                            icon: Icon(CupertinoIcons.search,
                                color: bgcolor, size: 30),
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: SearchHotels(
                                    hotelnames,
                                  ));
                            },
                          ),
                        ),
                      ],
                    )),
              )
            ]),
          );
        });
  }
}
