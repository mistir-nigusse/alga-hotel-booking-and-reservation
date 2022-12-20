import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/date_selector.dart';
import 'package:nearby_hotel_detction_booking_app/Components/services_check_box.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/bookin_page_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/history.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/reservation_form_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class EditReservationFormMinified extends StatefulWidget {
  final roomindex;
  final serviceName;
  final hotelId;
  final roomId;
  final bookingid;
  EditReservationFormMinified(
      {Key? key,
      this.serviceName,
      this.hotelId,
      this.roomId,
      this.roomindex,
      this.bookingid})
      : super(key: key);

  @override
  _EditReservationFormMinifiedState createState() =>
      _EditReservationFormMinifiedState();
}

class _EditReservationFormMinifiedState
    extends State<EditReservationFormMinified> {
  String mutation = """
  mutation(\$userExtendStayBookingId: ID, \$userExtendStayCheckoutTime: String){
  userExtendStay(bookingId: \$userExtendStayBookingId,checkout_time: \$userExtendStayCheckoutTime) {
    message
  }
}
  """;
  TextEditingController firstnameController = TextEditingController();
  VariablesController variables = Get.put(VariablesController());
  TextEditingController email = TextEditingController();
  String? message;
  TextEditingController lastnameController = TextEditingController();
  BookingPageController bookingPageController =
      Get.put(BookingPageController());

  DateTime checkoutdate = DateTime.now();

  DateTime checkouttime = DateTime.now();
  bool dateoutcolor = false;
  bool timeoutcolor = false;
  List<int> items = List<int>.generate(6, (int index) => index);
  @override
  Widget build(BuildContext context) {
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
        child: Container(
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
                      color: Colors.grey, style: BorderStyle.solid, width: 1.5),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Premium sweet Room",
                        style: TextStyle(
                            fontSize: 18,
                            color: bgcolor,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Edit Reservation ",
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReservationDateInputField(
                              hintcolor: dateoutcolor
                                  ? Colors.black54
                                  : Colors.redAccent,
                              size: size.width * 0.35,
                              hintText: "Check-Out Date",
                              buttonfunction: () {
                                Get.defaultDialog(
                                  title: "Select check-Out Date ",
                                  content: DateSelector(
                                    datepicker: CupertinoDatePicker(
                                        initialDateTime: checkoutdate,
                                        minimumDate: checkoutdate,
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (datetime) {
                                          setState(() {
                                            this.checkoutdate = datetime;
                                          });
                                        }),
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
                                      minimumDate: checkouttime,
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (datetime) {
                                        setState(() {
                                          this.checkouttime = datetime;
                                        });
                                      }),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 5),
                        child: ExpansionTile(
                            childrenPadding:
                                EdgeInsets.symmetric(horizontal: 5),
                            title: Text(
                              "Additioanl Services",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: bgcolor,
                                  fontSize: 15),
                            ),
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ServicesCheckBox();
                                  }),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0, top: 10),
                        child: Center(
                          child: Mutation(
                              options: MutationOptions(
                                document: gql(mutation),
                                update: (GraphQLDataProxy cache,
                                    QueryResult? result) {
                                  return cache;
                                },
                                onCompleted: (dynamic resultData) {
                                  Get.snackbar("Success",
                                      "You have Edited your reservation successfully ",
                                      snackPosition: SnackPosition.TOP,
                                      colorText: bgcolor,
                                      backgroundColor: Colors.white,
                                      borderColor: bgcolor,
                                      duration: Duration(seconds: 1),
                                      animationDuration: Duration(seconds: 1),
                                      borderRadius: 15,
                                      borderWidth: 2.5);
                                  print('finished lgg');
                                  //  print(token);
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
                                      backwidget: History(),
                                    );
                                  } else {
                                    return ErrorPage2(
                                      backwidget: History(),
                                      messagetext: message ?? "",
                                    );
                                  }
                                }
                                return GetBuilder<BookingPageController>(
                                    builder: (_) {
                                  return RoundedButton5(
                                    press: () {
                                      runMutation({
                                        'userExtendStayBookingId':
                                            widget.bookingid,
                                        'userExtendStayCheckoutTime':
                                            DateFormat('EEE MMM dd yyyy ')
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
                                    text: 'Save',
                                    color: bgcolor,
                                    size: size.width * 0.45,
                                  );
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
