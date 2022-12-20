import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/places_detail.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_list.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/place_query.dart';
import 'package:provider/single_child_widget.dart';

import '../../Components/No internet Connection/error_page.dart';
import '../../Components/places_card.dart';
import '../../Costants/constants.dart';

class PlaceByState extends StatefulWidget {
  const PlaceByState({Key? key}) : super(key: key);

  @override
  State<PlaceByState> createState() => _PlaceByStateState();
}

class _PlaceByStateState extends State<PlaceByState> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      //'http://192.168.1.10:5000/graphql',
      'http://157.230.190.157/graphql',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));

    return GraphQLProvider(
        client: client,
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  Query(
                      options: QueryOptions(
                        document: gql(PlacesQuery().placesQuery),
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
                              messagetext:
                                  result.exception!.graphqlErrors[0].message,
                            );
                          }
                        }

                        if (result.isLoading) {
                          print("loading");
                          //  return Center(child:  CircularProgressIndicator(color: bgcolor));
                          return Center(
                              child: CircularProgressIndicator(color: bgcolor));
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 20),
                          child: GridView.builder(
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisSpacing: kDefaultPaddin,
                              crossAxisSpacing: kDefaultPaddin,
                              childAspectRatio: 0.75,
                              maxCrossAxisExtent: 170,
                            ),
                            itemCount: result.data?['viewHotelsState'].length,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return Placescard(
                                image:
                                    "http://157.230.190.157/static/media/Alga-logo.7447e436.png",
                                title: "place name",
                                press: () {
                                  var location = result.data?['viewHotelsState']
                                      [index]['location'];
                                  print(location.toString());
                                  /*  Get.to(() => PlacesDetails(
                                        title: ,
                                      ));*/
                                },
                              );
                            },
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
