import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Hotellist_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_list.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_query.dart';

class BestDeals extends StatefulWidget {
  const BestDeals({Key? key}) : super(key: key);

  @override
  State<BestDeals> createState() => _BestDealsState();
}

class _BestDealsState extends State<BestDeals> {
  final VariablesController variables = Get.put(VariablesController());
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
                backwidget: Hotels(),
              );
            } else {
              return ErrorPage2(
                backwidget: Hotels(),
                messagetext: result.exception!.graphqlErrors[0].message,
              );
            }
          }

          if (result.isLoading) {
            print("loading");
            //  return Center(child:  CircularProgressIndicator(color: bgcolor));
            return Center(child: CircularProgressIndicator(color: bgcolor));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: result.data?['userViewHotels'].length,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (BuildContext context, int index) {
              return HotelListCart2(
                star: result.data?['userViewHotels'][index]['star'],
                index: index,
                address: result.data?['userViewHotels'][index]['location']
                        ['state'] +
                    ", " +
                    result.data?['userViewHotels'][index]['location']['city'] +
                    ", " +
                    result.data?['userViewHotels'][index]['location']['wereda'],
                onpress: () {
                  List<String> hotels = [];
                  int y =
                      result.data?['userViewHotels'][index]['roomTypes'].length;
                  String name = '';

                  for (int z = 0; z < y; z++) {
                    name = result.data?['userViewHotels'][index]['roomTypes'][z]
                        ['name'];
                    hotels.add(name);
                  }

                  variables.sethotelIndex(index);
                  variables
                      .setHotelid(result.data?['userViewHotels'][index]['Id']);

                  Get.to(() => TravelApp(
                        rating: result.data?['userViewHotels'][index]['rate']
                            ['rateAvarage'],
                        ratetotal: result.data?['userViewHotels'][index]['rate']
                            ['rateCount'],
                        aboutHoteldescription: result.data?['userViewHotels']
                            [index]['description'],
                        aboutHotelname: result.data?['userViewHotels'][index]
                            ['name'],
                        city: result.data?['userViewHotels'][index]['location']
                            ['city'],
                        wereda: result.data?['userViewHotels'][index]
                            ['location']['wereda'],
                        state: result.data?['userViewHotels'][index]['location']
                            ['state'],
                        email: result.data?['userViewHotels'][index]['email'],
                        phoneNo: result.data!['userViewHotels'][index]
                                ['phone_no']
                            .toString(),
                        aboutImageUrl: result.data?['userViewHotels'][index]
                            ['photos'][0]['imageURI'],
                        roomTypescount: index,
                        hotelName: hotels,
                        id: variables.hotelid,
                        hotelImageurl: result.data?['userViewHotels'][index]
                            ['photos'][0]['imageURI'],
                      ));
                },
                hotelImageUrl: result.data?['userViewHotels'][index]['photos']
                    [0]['imageURI'],
                hotelname: result.data?['userViewHotels'][index]['name'],
              );
            },
          );
        });
  }
}
