import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Hotellist_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/map_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/map_query.dart';

class SliverNearBy extends StatefulWidget {
  const SliverNearBy({Key? key}) : super(key: key);

  @override
  _SliverNearByState createState() => _SliverNearByState();
}

class _SliverNearByState extends State<SliverNearBy> {
  final VariablesController variables = Get.put(VariablesController());
  List<LatLng> hotelsPosition = [];
  late int length1 = 0;
  bool x = false;
  List<String?> hotelsname = [];
  List<String> hotelimageurl = [];
  List<int> hotelstar = [];
  List<double> hoteldist = [];
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'http://157.230.190.157/graphql',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return Scaffold(
      body: GraphQLProvider(
        client: client,
        child: Query(
            options: QueryOptions(
              document: gql(MapQuery().mapQuery),
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
              int hotelslength = result.data?['nearByHotel'].length;
              length1 = hotelslength;

              for (int i = 0; i < hotelslength; i++) {
                LatLng positions = LatLng(
                    result.data!['nearByHotel'][i]['address']['lat'],
                    result.data!['nearByHotel'][i]['address']['long']);
                hotelsPosition.add(positions);
                String? hotelname = result.data?['nearByHotel'][i]['name'];
                hotelsname.add(hotelname!.toUpperCase());
                int star = result.data?['nearByHotel'][i]['star'];
                hotelstar.add(star);
                String imageurl =
                    result.data!['nearByHotel'][i]['photos'][0]['imageURI'];
                hotelimageurl.add(imageurl);
                double dist = result.data?['nearByHotel'][i]['distance'];
                hoteldist.add(dist);
              }
              return MainPage(
                hotelIMageUrls: hotelimageurl,
                hotelnames: hotelsname,
                index1: 1,
                onpress: '',
                count: length1,
                star: hotelstar,
              );
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(
              //           top: 40,
              //           left: 20.0,
              //         ),
              //         child: AutoSizeText(
              //           "Nearby Hotels",
              //           style: TextStyle(color: bgcolor),
              //         ),
              //       ),
              //       Expanded(
              //           child: x
              //               ? ListView.builder(
              //                   shrinkWrap: true,
              //                   itemCount: length1,
              //                   physics: NeverScrollableScrollPhysics(),
              //                   padding: const EdgeInsets.symmetric(horizontal: 5),
              //                   itemBuilder: (BuildContext context, int index) {
              //                     return HotelListCart(
              //                       index: 1,
              //                       address: "",
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
              //                         variables.setHotelid(result
              //                             .data?['userViewHotels'][index]['Id']);

              //                         Get.to(() => TravelApp(
              //                               rating: result.data?['userViewHotels']
              //                                   [index]['rate']['rateAvarage'],
              //                               ratetotal: result.data?['userViewHotels']
              //                                   [index]['rate']['rateCount'],
              //                               aboutHoteldescription:
              //                                   result.data?['userViewHotels'][index]
              //                                       ['description'],
              //                               aboutHotelname:
              //                                   result.data?['userViewHotels'][index]
              //                                       ['name'],
              //                               city: result.data?['userViewHotels']
              //                                   [index]['location']['city'],
              //                               wereda: result.data?['userViewHotels']
              //                                   [index]['location']['wereda'],
              //                               state: result.data?['userViewHotels']
              //                                   [index]['location']['state'],
              //                               email: result.data?['userViewHotels']
              //                                   [index]['email'],
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
              //                       hotelImageUrl: hotelimageurl[index],
              //                       star: hotelstar[index],
              //                       hotelname: hotelsname[index]!,
              //                     );
              //                   })
              //               : Center(
              //                   child: AutoSizeText(
              //                   'Please select your location',
              //                   style: TextStyle(fontSize: 18, color: bgcolor),
              //                 ))),
              //     ],
              //   );
              //
            }),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final hotelIMageUrls;
  final count;
  final hotelnames;
  final onpress;
  final index1;
  final star;
  MainPage(
      {Key? key,
      this.count,
      this.hotelIMageUrls,
      this.hotelnames,
      this.onpress,
      this.index1,
      this.star});
  @override
  _MainPageState createState() => _MainPageState();
}

bool x = false;

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (x == true)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
                itemCount: widget.count,
                itemBuilder: (context, index) {
                  return HotelListCart(
                      address: "",
                      onpress: () {},
                      hotelname: widget.hotelnames[index],
                      hotelImageUrl: widget.hotelIMageUrls[index],
                      star: widget.star[index],
                      index: widget.index1);
                }),
          ),
        if (x == false) Text('Please select your location'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  x = true;
                });
                print(widget.hotelnames);
              },
              child: Text('dd')),
        )
      ],
    );
  }
}
