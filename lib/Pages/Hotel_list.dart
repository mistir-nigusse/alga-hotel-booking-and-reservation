import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/search_delegates.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/placesbyState.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/all_hotels.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/best_deals.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/gallery.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/map_page.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/places.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_query.dart';

class Hotels extends StatefulWidget {
  Hotels({Key? key}) : super(key: key);

  @override
  _HotelsState createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  // final VariablesController variables = Get.put(VariablesController());
  // late CarouselController _controller;

  @override
  void initState() {
    // _controller = CarouselController();
    super.initState();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              backgroundColor: Color(0xFFF6F7FF),
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(0xFFF6F7FF),
                  toolbarHeight: MediaQuery.of(context).size.height / 14,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "Find Hotels",
                    style: TextStyle(color: bgcolor),
                  ),
                  leading: Builder(
                      builder: (con) => IconButton(
                            icon:
                                Icon(CupertinoIcons.list_dash, color: bgcolor),
                            onPressed: () => Scaffold.of(con).openDrawer(),
                          )),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: SearchHotels(hotelnames));
                      },
                      icon:
                          Icon(CupertinoIcons.search, color: bgcolor, size: 30),
                    )
                  ]),
              drawer: Mydrawer(),
              body: Container(
                height: height,
                width: width,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      SafeArea(
                        child: SizedBox(
                          height: 40,
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: bgcolor,
                            tabs: [
                              Tab(
                                child: Text("Hotels",
                                    style: TextStyle(color: bgcolor)),
                              ),
                              Tab(
                                  child: Text("Best Deals",
                                      style: TextStyle(color: bgcolor))),
                              Tab(
                                  child: Text("Places",
                                      style: TextStyle(color: bgcolor))),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [AllHotels(), BestDeals(), PlaceByState()],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
  //  Padding(
  //               padding:
  //                   const EdgeInsets.only(top: 10.0, left: 20, bottom: 5),
  //               child: Text(
  //                 "All Hotels",
  //                 style: TextStyle(color: bgcolor),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 5),
  //                 color: Color(0xFFF6F7FF),
  //                 height: MediaQuery.of(context).size.height,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: result.data?['userViewHotels'].length,
  //                   padding: const EdgeInsets.symmetric(horizontal: 5),
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return HotelListCart(
  //                       star: result.data?['userViewHotels'][index]['star'],
  //                       index: index,
  //                       address: result.data?['userViewHotels'][index]
  //                               ['location']['state'] +
  //                           ", " +
  //                           result.data?['userViewHotels'][index]
  //                               ['location']['city'] +
  //                           ", " +
  //                           result.data?['userViewHotels'][index]
  //                               ['location']['wereda'],
  //                       onpress: () {
  //                         List<String> hotels = [];
  //                         int y = result
  //                             .data?['userViewHotels'][index]['roomTypes']
  //                             .length;
  //                         String name = '';

  //                         for (int z = 0; z < y; z++) {
  //                           name = result.data?['userViewHotels'][index]
  //                               ['roomTypes'][z]['name'];
  //                           hotels.add(name);
  //                         }

  //                         variables.sethotelIndex(index);
  //                         variables.setHotelid(
  //                             result.data?['userViewHotels'][index]['Id']);

  //                         Get.to(() => TravelApp(
  //                               rating: result.data?['userViewHotels']
  //                                   [index]['rate']['rateAvarage'],
  //                               ratetotal: result.data?['userViewHotels']
  //                                   [index]['rate']['rateCount'],
  //                               aboutHoteldescription:
  //                                   result.data?['userViewHotels'][index]
  //                                       ['description'],
  //                               aboutHotelname: result
  //                                   .data?['userViewHotels'][index]['name'],
  //                               city: result.data?['userViewHotels'][index]
  //                                   ['location']['city'],
  //                               wereda: result.data?['userViewHotels']
  //                                   [index]['location']['wereda'],
  //                               state: result.data?['userViewHotels'][index]
  //                                   ['location']['state'],
  //                               email: result.data?['userViewHotels'][index]
  //                                   ['email'],
  //                               phoneNo: result.data!['userViewHotels']
  //                                       [index]['phone_no']
  //                                   .toString(),
  //                               aboutImageUrl:
  //                                   result.data?['userViewHotels'][index]
  //                                       ['photos'][0]['imageURI'],
  //                               roomTypescount: index,
  //                               hotelName: hotels,
  //                               id: variables.hotelid,
  //                               hotelImageurl:
  //                                   result.data?['userViewHotels'][index]
  //                                       ['photos'][0]['imageURI'],
  //                             ));
  //                       },
  //                       hotelImageUrl: result.data?['userViewHotels'][index]
  //                           ['photos'][0]['imageURI'],
  //                       hotelname: result.data?['userViewHotels'][index]
  //                           ['name'],
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ),

}
