import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/favorite_list_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/favorite_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_query.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key, this.count}) : super(key: key);
  final count;
  @override
  _FavoritesState createState() => _FavoritesState();
}

List<int> items = List<int>.generate(10, (int index) => index);

class _FavoritesState extends State<Favorites> {
  Fav favcont = Get.put(Fav());
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('http://157.230.190.157/graphql');

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: MediaQuery.of(context).size.height / 14,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Favorites",
            style: TextStyle(color: bgcolor),
          ),
          leading: Builder(
              builder: (con) => IconButton(
                    icon: Icon(CupertinoIcons.list_dash, color: bgcolor),
                    onPressed: () => Scaffold.of(con).openDrawer(),
                  )),
        ),
        drawer: Mydrawer(),
        body: Query(
            options: QueryOptions(document: gql(AllHotelQuery().allhotelquery)),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                if (result.exception!.linkException != null) {
                  return ErrorPage(
                    backwidget: Favorites(),
                  );
                } else {
                  return ErrorPage2(
                    backwidget: Favorites(),
                    messagetext: result.exception!.graphqlErrors[0].message,
                  );
                }
              }

              if (result.isLoading) {
                print("loading");
                return Center(child: CircularProgressIndicator(color: bgcolor));
              }
              return ListView.builder(
                itemCount: favcont.getName().length,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (BuildContext context, int index) {
                  List<String> totalHotels = [];
                  int hotelcount = result.data?['userViewHotels'].length;
                  for (int i = 0; i < hotelcount; i++) {
                    String name = result.data?['userViewHotels'][i]['name'];
                    totalHotels.add(name);
                    favcont.settotalHotelNames(name);
                  }

                  int k =
                      favcont.gettotalName().indexOf(favcont.getName()[index]);
                  List favoriteitem = favcont.getName();
                  return Dismissible(
                      key: ValueKey<String>(favoriteitem[index]),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          favoriteitem.removeAt(index);
                          favcont.favhotelstorage.write('name', favoriteitem);
                        });
                        Get.snackbar("Success", "Favorite hotel removed",
                            snackPosition: SnackPosition.TOP,
                            colorText: bgcolor,
                            backgroundColor: Colors.white,
                            borderColor: bgcolor,
                            duration: Duration(seconds: 1),
                            animationDuration: Duration(seconds: 1),
                            borderRadius: 15,
                            borderWidth: 2.5);
                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Spacer(),
                            Icon(
                              CupertinoIcons.trash,
                              color: bgcolor,
                            ),
                          ],
                        ),
                      ),
                      child: FavoriteListCart(
                        onPress: () {
                          print(k);
                          print(favcont.totalHotelsname);
                          List<String> hotelnames = [];
                          List<String> difference = [];

                          for (final e in favcont.getName()) {
                            bool found = false;
                            for (final f in favcont.gettotalName()) {
                              if (e == f) {
                                found = true;
                                break;
                              }
                            }
                            if (!found) {
                              difference.add(e);
                            }
                          }
                          print("errrrrrrrrrrrrrrrrr");
                          if (!difference.contains(favcont.getName()[index])) {
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    widget: TravelApp(
                                  aboutHoteldescription:
                                      result.data?['userViewHotels'][k]
                                          ['description'],
                                  aboutHotelname: result.data?['userViewHotels']
                                      [k]['name'],
                                  city: result.data?['userViewHotels'][k]
                                      ['location']['city'],
                                  wereda: result.data?['userViewHotels'][k]
                                      ['location']['wereda'],
                                  state: result.data?['userViewHotels'][k]
                                      ['location']['state'],
                                  email: result.data?['userViewHotels'][k]
                                      ['email'],
                                  phoneNo: result.data!['userViewHotels'][k]
                                          ['phone_no']
                                      .toString(),
                                  aboutImageUrl: result.data?['userViewHotels']
                                      [k]['photos'][0]['imageURI'],
                                  roomTypescount: k,
                                  hotelName: hotelnames,
                                  id: result.data?['userViewHotels'][k]['Id'],
                                  hotelImageurl: result.data?['userViewHotels']
                                      [k]['photos'][0]['imageURI'],
                                )));
                          } else {
                            Get.snackbar("Warning",
                                "Hotel no longer found might be removed",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: bgcolor,
                                backgroundColor: Colors.white,
                                borderColor: bgcolor,
                                duration: Duration(seconds: 1),
                                animationDuration: Duration(seconds: 1),
                                borderRadius: 15,
                                borderWidth: 2.5);
                          }
                        },
                        hotelImageurl: favcont.geturl()[index],
                        hotelName: favcont.getName()[index],
                      ));
                },
              );
            }),
      ),
    );
  }
}
