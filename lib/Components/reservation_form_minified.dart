import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/date_selector.dart';
import 'package:nearby_hotel_detction_booking_app/Components/services.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/bookin_page_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/rooms.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/Reservation_mutation.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_query.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/reservation_form_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class ReserveFormMinified extends StatefulWidget {
  final roomindex;
  final serviceName;
  final hotelId;
  final roomId;
  final roomtypename;
  final hotelindex;
  final roomtypeindex;
  ReserveFormMinified(
      {Key? key,
      this.serviceName,
      this.hotelId,
      this.roomId,
      this.roomindex,
      this.roomtypename,
      this.hotelindex,
      this.roomtypeindex})
      : super(key: key);

  @override
  _ReserveFormMinifiedState createState() => _ReserveFormMinifiedState();
}

class _ReserveFormMinifiedState extends State<ReserveFormMinified> {
  @override
  TextEditingController email = TextEditingController();

  List<String> roomNos = [];
  List<String> roomsId = [];
  String? temp;
  String selectedid = "";
  String? message;
  BookingPageController bookingPageController =
      Get.put(BookingPageController());
  final VariablesController variableController = Get.put(VariablesController());
  DateTime checkindate = DateTime.now();
  DateTime checkoutdate = DateTime.now();
  DateTime checkintime = DateTime.now();
  DateTime checkouttime = DateTime.now();
  bool dateincolor = false;
  bool dateoutcolor = false;
  bool timeincolor = false;
  bool timeoutcolor = false;
  @override
  Widget build(BuildContext context) {
    DateTime minimumdate = DateTime.now();
    DateTime minimumtime = DateTime.now();
    Size size = MediaQuery.of(context).size;
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
      child: Query(
          options: QueryOptions(
            document: gql(AllHotelQuery().allhotelquery),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              if (result.exception!.linkException != null) {
                return Expanded(
                  child: ErrorPage(
                    backwidget: ReserveFormMinified(),
                  ),
                );
              } else {
                return Expanded(
                  child: ErrorPage2(
                    backwidget: ReserveFormMinified(),
                    messagetext: result.exception!.graphqlErrors[0].message,
                  ),
                );
              }
            }

            if (result.isLoading) {
              return Center(child: CircularProgressIndicator(color: bgcolor));
            }
            int roomsCount = result
                .data?['userViewHotels'][widget.hotelindex]['roomTypes']
                    [widget.roomtypeindex]['rooms']
                .length;
            String roomNo;
            String id;
            int floorNo;

            List<int> floorNos = [];

            for (int z = 0; z < roomsCount; z++) {
              roomNo = result.data?['userViewHotels'][widget.hotelindex]
                  ['roomTypes'][widget.roomtypeindex]['rooms'][z]['room_no'];
              roomNos.add(roomNo);
              floorNo = result.data?['userViewHotels'][widget.hotelindex]
                  ['roomTypes'][widget.roomtypeindex]['rooms'][z]['floor_no'];
              floorNos.add(floorNo);
              variables.setroomsno(roomNos);
              variables.setfloorno(floorNos);
              id = result.data?['userViewHotels'][widget.hotelindex]
                  ['roomTypes'][widget.roomtypeindex]['rooms'][z]['Id'];
              roomsId.add(id);
            }

            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.6,
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
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.5),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            widget.roomtypename,
                            style: TextStyle(
                                fontSize: 18,
                                color: bgcolor,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Reservation form",
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ReservationDateInputField(
                                hintcolor: dateincolor
                                    ? Colors.black54
                                    : Colors.redAccent,
                                size: size.width * 0.42,
                                hintText: "Check-In Date *",
                                buttonfunction: () {
                                  Get.defaultDialog(
                                    title: "Select check-in Date ",
                                    content: DateSelector(
                                      datepicker: CupertinoDatePicker(
                                        initialDateTime: checkindate,
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (datetime) {
                                          setState(() {
                                            this.checkindate = datetime;
                                          });
                                        },
                                        minimumDate: checkindate,
                                      ),
                                    ),
                                    backgroundColor: kPrimaryLightColor,
                                    confirm: RoundedButton5(
                                      text: "Confirm",
                                      press: () {
                                        print("checkindate " +
                                            checkindate.toString());
                                        bookingPageController
                                            .updateDateIn(checkindate);
                                        Navigator.pop(context);
                                        setState(() {
                                          dateincolor = true;
                                        });
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.25,
                                    ),
                                    cancel: RoundedButton5(
                                      text: "Cancel",
                                      press: () {
                                        Navigator.pop(context);
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.25,
                                    ),
                                  );
                                },
                                data: GetBuilder<BookingPageController>(
                                  builder: (_) {
                                    return Center(
                                      child: Text(
                                        DateFormat('EEE, M/d/y')
                                            .format(bookingPageController
                                                .currentDatein)
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                                icons: Icons.calendar_today_outlined,
                              ),
                              ReservationDateInputField(
                                hintcolor: timeincolor
                                    ? Colors.black54
                                    : Colors.redAccent,
                                size: size.width * 0.3,
                                hintText: "Check-In Time *",
                                data: GetBuilder<BookingPageController>(
                                  builder: (_) {
                                    return Center(
                                      child: Text(
                                        DateFormat('hh:mm a')
                                            .format(bookingPageController
                                                .curentTimein)
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                                buttonfunction: () {
                                  Get.defaultDialog(
                                    content: TimeSelector(
                                      timepicker: CupertinoDatePicker(
                                        initialDateTime: checkintime,
                                        mode: CupertinoDatePickerMode.time,
                                        onDateTimeChanged: (datetime) {
                                          setState(() {
                                            this.checkintime = datetime;
                                            minimumtime = checkintime;
                                          });
                                        },
                                      ),
                                    ),
                                    confirm: RoundedButton5(
                                      text: "Confirm",
                                      press: () {
                                        bookingPageController
                                            .updateTimeIn(checkintime);
                                        Navigator.pop(context);
                                        setState(() {
                                          timeincolor = true;
                                        });
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.25,
                                    ),
                                    cancel: RoundedButton5(
                                      text: "Cancel",
                                      press: () {
                                        Navigator.pop(context);
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.25,
                                    ),
                                    title: "Select check-in time ",
                                    backgroundColor: kPrimaryLightColor,
                                  );
                                },
                                icons: Icons.alarm,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ReservationDateInputField(
                                  hintcolor: dateoutcolor
                                      ? Colors.black54
                                      : Colors.redAccent,
                                  size: size.width * 0.42,
                                  hintText: "Check-Out Date",
                                  buttonfunction: () {
                                    Get.defaultDialog(
                                      title: "Select check-Out Date ",
                                      content: DateSelector(
                                        datepicker: CupertinoDatePicker(
                                          // initialDateTime: checkindate,
                                          // minimumDate: checkindate,
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (datetime) {
                                            setState(() {
                                              this.checkoutdate = datetime;
                                            });
                                          },
                                        ),
                                      ),
                                      backgroundColor: kPrimaryLightColor,
                                      confirm: RoundedButton5(
                                        text: "Confirm",
                                        press: () {
                                          bookingPageController
                                              .updateDateOut(checkoutdate);
                                          print(checkoutdate);
                                          Navigator.pop(context);
                                          setState(() {
                                            dateoutcolor = true;
                                          });
                                        },
                                        color: bgcolor,
                                        size: size.width * 0.25,
                                      ),
                                      cancel: RoundedButton5(
                                        text: "Cancel",
                                        press: () {
                                          Navigator.pop(context);
                                        },
                                        color: bgcolor,
                                        size: size.width * 0.25,
                                      ),
                                    );
                                  },
                                  icons: Icons.calendar_today_outlined,
                                  data: GetBuilder<BookingPageController>(
                                      builder: (_) {
                                    return Center(
                                      child: Text(
                                        DateFormat('EEE, M/d/y')
                                            .format(bookingPageController
                                                .currentDateout)
                                            .toString(),
                                      ),
                                    );
                                  })),
                              ReservationDateInputField(
                                hintcolor: timeoutcolor
                                    ? Colors.black54
                                    : Colors.redAccent,
                                size: size.width * 0.3,
                                hintText: "Check-Out Time",
                                data: GetBuilder<BookingPageController>(
                                  builder: (_) {
                                    return Center(
                                      child: Text(
                                        DateFormat('hh:mm a')
                                            .format(bookingPageController
                                                .currentTimeout)
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                                buttonfunction: () {
                                  Get.defaultDialog(
                                    content: TimeSelector(
                                      timepicker: CupertinoDatePicker(
                                          initialDateTime: checkouttime,
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (datetime) {
                                            setState(() {
                                              this.checkouttime = datetime;
                                            });
                                          },
                                          minimumDate: minimumdate),
                                    ),
                                    confirm: RoundedButton5(
                                      text: "Confirm",
                                      press: () {
                                        bookingPageController
                                            .updateTimeout(checkouttime);
                                        Navigator.pop(context);
                                        setState(() {
                                          timeoutcolor = true;
                                        });
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.25,
                                    ),
                                    cancel: RoundedButton5(
                                      text: "Cancel",
                                      press: () {
                                        Navigator.pop(context);
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.25,
                                    ),
                                    title: "Select check-Out time ",
                                    backgroundColor: kPrimaryLightColor,
                                  );
                                },
                                icons: Icons.alarm,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Additioanl Services",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: bgcolor,
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                  // padding: const EdgeInsets.all(10.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: variables.serviceIcon.length,
                                      itemBuilder: (context, index) {
                                        print("this is what i am printing...." +
                                            variables.serviceIcon[index]
                                                .toString());
                                        return ServicesCard(
                                          serviceIcon: variables
                                              .serviceIcon[index]
                                              .toString(),
                                          servicesname:
                                              variables.servicesName[index],
                                        );
                                      })),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 40.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Mutation(
                                    options: MutationOptions(
                                      document: gql(ResevationMutation()
                                          .reservationmutation),
                                      update: (GraphQLDataProxy cache,
                                          QueryResult? result) {
                                        if (result!.hasException) {
                                          if (result.exception!.linkException !=
                                              null) {
                                            return Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: bgcolor, width: 2),
                                                  color: kPrimaryLightColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 400,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: AlertDialog(
                                                  title: Text(
                                                      "Oops something went wrong"),
                                                  content: Text(result
                                                      .exception!.linkException
                                                      .toString()),
                                                  actions: [
                                                    InkWell(
                                                      child: Text("Retry"),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Stack(children: [
                                              Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: bgcolor,
                                                        width: 2),
                                                    color: kPrimaryLightColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.3,
                                                  child: Center(
                                                    child: AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      insetPadding:
                                                          EdgeInsets.all(2),
                                                      titlePadding:
                                                          EdgeInsets.all(2),
                                                      title: AutoSizeText(
                                                        "Warning,can't create reservation",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      content: Text(result
                                                          .exception!
                                                          .linkException
                                                          .toString()),
                                                      actions: [
                                                        InkWell(
                                                          child: Container(
                                                              width: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        bgcolor,
                                                                    width: 2),
                                                                color:
                                                                    kPrimaryLightColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Retry"))),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]);
                                            // return ErrorPage2(
                                            //   backwidget: ReserveForm(),
                                            //   messagetext: message ?? "",
                                            // );
                                          }
                                        }

                                        print('finished lgg');
                                        return cache;
                                      },
                                      onCompleted: (dynamic resultData) {
                                        //  print(token);
                                      },
                                      onError: (error) {
                                        //print(error);
                                        setState(() {
                                          message =
                                              error!.graphqlErrors[0].message;
                                          print(message);
                                        });
                                      },
                                    ),
                                    builder: (
                                      RunMutation runMutation,
                                      QueryResult? result,
                                    ) {
                                      if (result!.hasException) {
                                        if (result.exception!.linkException !=
                                            null) {
                                          return Center(
                                            child: Container(
                                              height: 400,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: AlertDialog(
                                                title: Text(
                                                    "oops something went wrong"),
                                                content: Text(result
                                                    .exception!.linkException
                                                    .toString()),
                                                actions: [
                                                  InkWell(
                                                    child: Text("Retry"),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: Container(
                                              height: 400,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: AlertDialog(
                                                title: Text(
                                                    "oops something went wrong"),
                                                content: Text(result
                                                    .exception!.linkException
                                                    .toString()),
                                                actions: [
                                                  InkWell(
                                                    child: Text("Retry"),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      return GetBuilder<BookingPageController>(
                                          builder: (_) {
                                        return RoundedButton5(
                                          press: () {
                                            runMutation({
                                              'roomId': widget.roomId,
                                              'hotelId': widget.hotelId,
                                              'checkin_time': DateFormat(
                                                          'EEE MMM dd yyyy ')
                                                      .format(
                                                          bookingPageController
                                                              .currentDatein) +
                                                  bookingPageController
                                                      .curentTimein.hour
                                                      .toString() +
                                                  ':' +
                                                  bookingPageController
                                                      .curentTimein.minute
                                                      .toString() +
                                                  ':00',
                                              'checkout_time': DateFormat(
                                                          'EEE MMM dd yyyy ')
                                                      .format(
                                                          bookingPageController
                                                              .currentDateout) +
                                                  bookingPageController
                                                      .currentTimeout.hour
                                                      .toString() +
                                                  ':' +
                                                  bookingPageController
                                                      .currentTimeout.minute
                                                      .toString() +
                                                  ':00'
                                            });
                                          },
                                          text: 'Reserve',
                                          color: bgcolor,
                                          size: size.width * 0.45,
                                        );
                                      });
                                    }),
                                RoundedButton5(
                                  press: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           PaymentScreen()),
                                    // );
                                    Get.snackbar("coming soon ",
                                        "We are working on booking feture, it will be on the next version of the app",
                                        snackPosition: SnackPosition.TOP,
                                        colorText: bgcolor,
                                        backgroundColor: Colors.white,
                                        borderColor: bgcolor,
                                        duration: Duration(seconds: 1),
                                        animationDuration: Duration(seconds: 1),
                                        borderRadius: 15,
                                        borderWidth: 2.5);
                                  },
                                  text: 'Book',
                                  color: bgcolor,
                                  size: size.width * 0.45,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
