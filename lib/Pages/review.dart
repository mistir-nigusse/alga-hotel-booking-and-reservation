import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/user_data.dart';
//import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/comment_query_mutation.dart';

class Commentread extends StatefulWidget {
  late String ratetotal;
  final roomTypescount;
  Commentread({
    Key? key,
    this.roomTypescount,
  }) : super(key: key);

  @override
  _CommentreadState createState() => _CommentreadState();
}

class _CommentreadState extends State<Commentread> {
  TextEditingController commentbody = TextEditingController();
  VariablesController variables = Get.put(VariablesController());
  User user = Get.put(User());
  String? message;
  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Color(0xFFF6F7FF),
          body: Query(
              options: QueryOptions(
                document: gql(CommentQueryMutation().commentquery),
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  if (result.exception!.linkException != null) {
                    return ErrorPage(
                      backwidget: Commentread(),
                    );
                  } else {
                    return ErrorPage2(
                      backwidget: Commentread(),
                      messagetext: result.exception!.graphqlErrors[0].message,
                    );
                  }
                }

                if (result.isLoading) {
                  return Center(
                      child: CircularProgressIndicator(color: bgcolor));
                }
                int commentCount = result
                    .data?['userViewHotels'][widget.roomTypescount]['comments']
                    .length;
                List<String> comments = [];
                List<String> users = [];
                List<String> createdAt = [];
                for (int i = 0; i < commentCount; i++) {
                  String comment = result.data?['userViewHotels']
                      [widget.roomTypescount]['comments'][i]['body'];
                  comments.add(comment);
                  String name = result.data?['userViewHotels']
                              [widget.roomTypescount]['comments'][i]['user']
                          ['firstName'] +
                      ' ' +
                      result.data?['userViewHotels'][widget.roomTypescount]
                          ['comments'][i]['user']['middleName'];

                  users.add(name);
                  String date = result.data?['userViewHotels']
                      [widget.roomTypescount]['comments'][i]['createdAt'];
                  createdAt.add(date);
                }
                String rating = result.data!['userViewHotels']
                        [widget.roomTypescount]['rate']['rateAvarage']
                    .toStringAsFixed(1);

                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            border: Border.all(
                                color: bgcolor,
                                style: BorderStyle.solid,
                                width: 1.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 10),
                                child: Column(
                                  children: [
                                    AutoSizeText(
                                      rating,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: bgcolor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RatingBarIndicator(
                                      rating: double.parse(result
                                          .data!['userViewHotels']
                                              [widget.roomTypescount]['rate']
                                              ['rateAvarage']
                                          .toString()),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      direction: Axis.horizontal,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: AutoSizeText(result
                                              .data!['userViewHotels']
                                                  [widget.roomTypescount]
                                                  ['rate']['rateCount']
                                              .toString() +
                                          ' Ratings'),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Mutation(
                                        options: MutationOptions(
                                          document: gql(CommentQueryMutation()
                                              .commentmutation2),
                                          update: (GraphQLDataProxy cache,
                                              QueryResult? result) {
                                            return cache;
                                          },
                                          onCompleted: (dynamic resultData) {
                                            commentbody.text = '';
                                            //Get.back();
                                            print('finished gg');
                                          },
                                          onError: (error) {
                                            //print(error);
                                            setState(() {
                                              message = error!
                                                  .graphqlErrors[0].message;
                                            });
                                          },
                                        ),
                                        builder: (
                                          RunMutation runMutation,
                                          QueryResult? result,
                                        ) {
                                          if (result!.hasException) {
                                            if (result
                                                    .exception!.linkException !=
                                                null) {
                                              return ErrorPage(
                                                backwidget: Commentread(),
                                              );
                                            } else {
                                              return ErrorPage2(
                                                backwidget: Commentread(),
                                                messagetext: message ?? "",
                                              );
                                            }
                                          }
                                          return RatingBar.builder(
                                            tapOnlyMode: true,
                                            itemSize: 18,
                                            glow: false,
                                            initialRating: 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              Get.snackbar("Success",
                                                  "You have rated this hotel",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText: bgcolor,
                                                  backgroundColor: Colors.white,
                                                  borderColor: bgcolor,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  animationDuration:
                                                      Duration(seconds: 1),
                                                  borderRadius: 15,
                                                  borderWidth: 2.5);
                                              runMutation({
                                                'rateHotelRate': rating,
                                                'rateHotelHotelId':
                                                    variables.hotelid
                                              });
                                              print(rating);
                                            },
                                          );
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Give your Rating Here",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AutoSizeText(
                            "Comments",
                            style: TextStyle(
                                fontSize: 17,
                                color: bgcolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: comments.length,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: bgcolor,
                                        style: BorderStyle.solid,
                                        width: 0.5),
                                    color: Color(0xFFF6F7FF),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0))),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.account_circle_outlined,
                                        color: bgcolor,
                                        size: 45,
                                      ),
                                      title: Text(
                                        users[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: bgcolor,
                                            fontSize: 15),
                                      ),
                                      subtitle: Text(
                                        DateFormat('d-MM-y').format(
                                            DateTime.parse(createdAt[index])),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: bgcolor,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, bottom: 15),
                                      child: Text(
                                        comments[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: bgcolor,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: bgcolor,
            child: Icon(
              Icons.add_comment_rounded,
              size: 30,
            ),
            onPressed: () {
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
              Get.bottomSheet(GraphQLProvider(
                client: client,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: bgcolor,
                            style: BorderStyle.solid,
                            width: 2.5),
                        color: Color(0xFFF6F7FF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: MediaQuery.of(context).size.height / 12,
                    // color: Colors.white,
                    child: Mutation(
                        options: MutationOptions(
                          document: gql(CommentQueryMutation().commentmutation),
                          update:
                              (GraphQLDataProxy cache, QueryResult? result) {
                            return cache;
                          },
                          onCompleted: (dynamic resultData) {
                            commentbody.text = '';
                            Get.back();
                            print('finished gg');
                          },
                          onError: (error) {
                            //print(error);
                            setState(() {
                              message = error!.graphqlErrors[0].message;
                            });
                          },
                        ),
                        builder: (
                          RunMutation runMutation,
                          QueryResult? result,
                        ) {
                          if (result!.hasException) {
                            if (result.exception!.linkException != null) {
                              return ErrorPage(
                                backwidget: Commentread(),
                              );
                            } else {
                              return ErrorPage2(
                                backwidget: Commentread(),
                                messagetext: message ?? "",
                              );
                            }
                          }
                          return Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.comment,
                                  color: bgcolor,
                                ),
                                iconSize: 25.0,
                                onPressed: () {},
                              ),
                              Expanded(
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  //   onChanged: (value) {},
                                  controller: commentbody,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Write a Review...',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: bgcolor,
                                ),
                                iconSize: 25.0,
                                onPressed: () {
                                  runMutation({
                                    'commentBody': commentbody.text,
                                    'commentHotelId': variables.hotelid,
                                    //
                                  });
                                  print('object');
                                },
                              ),
                            ],
                          );
                        })),
              ));
            },
          ),
        ));
  }
}
