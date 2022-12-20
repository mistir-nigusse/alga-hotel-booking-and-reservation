import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/hotel_list_card_widget.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/paymnet_page.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/rooms.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/Cancel_reservation_mutation.dart';

class HistoryReservationCard extends StatelessWidget {
  final reserveId;
  final String hotelname;
  final roomNo;
  final createdAt;
  final floorno;
  final checkInDate;
  final checkOutDate;
  final services;

  HistoryReservationCard({
    Key? key,
    this.reserveId,
    required this.hotelname,
    required this.roomNo,
    this.createdAt,
    required this.floorno,
    required this.checkInDate,
    required this.checkOutDate,
    this.services,
  }) : super(key: key);

  get roomTypescount => roomTypescount;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(
                color: bgcolor, style: BorderStyle.solid, width: 2.5),
            color: Color(0xFFF6F7FF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.symmetric(horizontal: 5),
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, FadePageRoute(widget: Checkout()));
              },
              icon: Icon(Icons.payment)),
          children: [
            Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Reservation Id :",
                        ),
                      ),
                      Expanded(
                        child: HistoryListCardWidget(
                          text: reserveId,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Room No. :",
                        ),
                      ),
                      Expanded(child: HistoryListCardWidget(text: roomNo)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Floor No. :",
                        ),
                      ),
                      Expanded(
                          child:
                              HistoryListCardWidget(text: floorno.toString())),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Check-In Date :",
                        ),
                      ),
                      Expanded(
                          child: HistoryListCardWidget(
                              text: DateFormat('d-MM-y')
                                  .format(DateTime.parse(checkInDate)))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Check-In Time :",
                        ),
                      ),
                      Expanded(
                        child: HistoryListCardWidget(
                          text: DateFormat('hh:mm a')
                              .format(DateTime.parse(checkInDate)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Check-Out Date :",
                        ),
                      ),
                      Expanded(
                        child: HistoryListCardWidget(
                          text: DateFormat('d-MM-y')
                              .format(DateTime.parse(checkOutDate)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: HistoryListCardWidget(
                          text: "Check-Out Time :",
                        ),
                      ),
                      Expanded(
                        child: HistoryListCardWidget(
                          text: DateFormat('hh:mm a')
                              .format(DateTime.parse(checkOutDate)),
                        ),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Mutation(
                        options: MutationOptions(
                          document: gql(CancelReservation().cancelreservation),
                          update:
                              (GraphQLDataProxy cache, QueryResult? result) {
                            return cache;
                          },
                          onCompleted: (dynamic resultData) {
                            //  print(token);
                          },
                        ),
                        builder: (
                          RunMutation runMutation,
                          QueryResult? result,
                        ) {
                          return TextButton(
                              onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                        'Cancel Reservation',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 12, 49, 54)),
                                      ),
                                      content: const Text(
                                          'Are you sure you want to cancel your reservation?',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 19, 77, 85))),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'No'),
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            print(reserveId + "cacelled");
                                            runMutation({
                                              'reservationId': reserveId,
                                            });
                                            Navigator.pop(context, 'Yes');
                                            Get.snackbar("Success",
                                                "Your reservation is cancelled successfully ",
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                colorText: bgcolor,
                                                backgroundColor: Colors.white,
                                                borderColor: Colors.red,
                                                duration: Duration(seconds: 1),
                                                animationDuration:
                                                    Duration(seconds: 1),
                                                borderRadius: 15,
                                                borderWidth: 2.5);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  ),
                              style: ButtonStyle(
                                  fixedSize:
                                      MaterialStateProperty.all(Size(70.0, 7)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 179, 19, 19))),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: bgcolor2, fontSize: 15),
                              ));
                        }),
                    SizedBox(
                      width: 30,
                    ),
                    Mutation(
                        options: MutationOptions(
                          // change the doucment to the appropriate booking mutation
                          document: gql(CancelReservation().cancelreservation),
                          update:
                              (GraphQLDataProxy cache, QueryResult? result) {
                            return cache;
                          },
                          onCompleted: (dynamic resultData) {
                            //  print(token);
                          },
                        ),
                        builder: (
                          RunMutation runMutation,
                          QueryResult? result,
                        ) {
                          return TextButton(
                              onPressed: () => {
                                    Get.snackbar("Feature not available",
                                        "This feature is not available currently, we are working on it",
                                        snackPosition: SnackPosition.TOP,
                                        colorText: bgcolor,
                                        backgroundColor: Colors.white,
                                        borderColor: Colors.red,
                                        duration: Duration(seconds: 5),
                                        animationDuration: Duration(seconds: 1),
                                        borderRadius: 15,
                                        borderWidth: 2.5)
                                  },
                              style: ButtonStyle(
                                  fixedSize:
                                      MaterialStateProperty.all(Size(50.0, 7)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0XFF318972))),
                              child: Text(
                                "Book now",
                                style: TextStyle(color: bgcolor2, fontSize: 15),
                              ));
                        }),
                  ]),
                ],
              ),
            ))
          ],
          // collapsedIconColor: bgcolor,
          subtitle: Text(
            DateFormat('d-MM-y').format(DateTime.parse(createdAt)),
            style: TextStyle(
                fontWeight: FontWeight.w400, color: bgcolor, fontSize: 15),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  hotelname.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: bgcolor,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ));
  }
}
