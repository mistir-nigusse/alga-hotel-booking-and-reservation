import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/date_selector.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/reservation_dialogue.dart';
import 'package:nearby_hotel_detction_booking_app/Components/services.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/bookin_page_controller.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/user_data.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/Reservation_mutation.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/reservation_form_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class ReserveForm extends StatefulWidget {
  final roomindex;
  final serviceName;
  final hotelId;
  final roomId;
  final roomno;
  final floorno;
  final price;
  ReserveForm(
      {Key? key,
      this.serviceName,
      this.hotelId,
      this.roomId,
      this.roomindex,
      this.roomno,
      this.floorno,
      this.price})
      : super(key: key);

  @override
  _ReserveFormState createState() => _ReserveFormState();
}

class _ReserveFormState extends State<ReserveForm> {
  String? message;
  TextEditingController firstnameController = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController lastnameController = TextEditingController();

  BookingPageController bookingPageController =
      Get.put(BookingPageController());
  DateTime checkindate = DateTime.now();
  DateTime checkoutdate = DateTime.now();
  DateTime checkintime = DateTime.now();
  DateTime checkouttime = DateTime.now();
  final VariablesController variables = Get.put(VariablesController());
  User usercontroller = Get.put(User());
  DateTime minimumdate = DateTime.now();
  DateTime minimumtime = DateTime.now();
  bool dateincolor = false;
  bool dateoutcolor = false;
  bool timeincolor = false;
  bool timeoutcolor = false;
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
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 16,
          elevation: 0.0,
          backgroundColor: Color(0xFFF6F7FF),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: bgcolor, size: 35),
            onPressed: () {
              Get.back();
            },
          ),
          automaticallyImplyLeading: false,
          title: Text(
            "Room Reservation Form",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "User Detail",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReservationInputField(
                        hintText: "First Name",
                        size: size.width * 0.4,
                        icon: Icons.person,
                        DataText: usercontroller.getFirstName()),
                    ReservationInputField(
                      size: size.width * 0.4,
                      hintText: "Middle Name",
                      icon: Icons.person,
                      DataText: usercontroller.getMiddleName(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReservationInputField(
                      size: size.width * 0.4,
                      hintText: "Last Name",
                      icon: Icons.person,
                      DataText: usercontroller.getLastName(),
                    ),
                    ReservationInputField(
                      size: size.width * 0.4,
                      hintText: "Nationality",
                      icon: Icons.person,
                      DataText: 'Ethiiopian',
                    )
                  ],
                ),
                ReservationInputField(
                  size: size.width * 0.6,
                  hintText: "Phone No",
                  icon: Icons.phone,
                  DataText: usercontroller.getPhonno(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ReservationInputField(
                        size: size.width * 0.7,
                        hintText: "Email address",
                        icon: Icons.mail,
                        DataText: usercontroller.getEmail(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Reservation Detail",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReservationInputField(
                      size: size.width * 0.4,
                      hintText: "Room No",
                      icon: Icons.hotel,
                      DataText: widget.roomno.toString(),
                    ),
                    ReservationInputField(
                      size: size.width * 0.4,
                      hintText: "Floor No",
                      icon: CupertinoIcons.building_2_fill,
                      DataText: widget.floorno.toString(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReservationDateInputField(
                        hintcolor:
                            dateincolor ? Colors.black54 : Colors.redAccent,
                        size: size.width * 0.42,
                        hintText: "Select Check-In Date *",
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
                                      minimumdate = checkindate;
                                    });
                                  }),
                            ),
                            backgroundColor: kPrimaryLightColor,
                            confirm: RoundedButton5(
                              text: "Confirm",
                              press: () {
                                print("checkindate " + checkindate.toString());
                                bookingPageController.updateDateIn(checkindate);
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
                                    .format(bookingPageController.currentDatein)
                                    .toString(),
                              ),
                            );
                          },
                        ),
                        icons: Icons.calendar_today_outlined,
                      ),
                      ReservationDateInputField(
                        hintcolor:
                            timeincolor ? Colors.black54 : Colors.redAccent,
                        size: size.width * 0.3,
                        hintText: "Select Check-In Time *",
                        data: GetBuilder<BookingPageController>(
                          builder: (_) {
                            return Center(
                              child: Text(
                                DateFormat('hh:mm a')
                                    .format(bookingPageController.curentTimein)
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
                                  // minimumDate: DateTime.now(),
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: (datetime) {
                                    setState(() {
                                      this.checkintime = datetime;
                                      minimumtime = checkintime;
                                    });
                                  }),
                            ),
                            confirm: RoundedButton5(
                              text: "Confirm",
                              press: () {
                                bookingPageController.updateTimeIn(checkintime);
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReservationDateInputField(
                        hintcolor:
                            dateoutcolor ? Colors.black54 : Colors.redAccent,
                        size: size.width * 0.42,
                        hintText: "Select Check-Out Date *",
                        buttonfunction: () {
                          Get.defaultDialog(
                            title: "Select check-Out Date ",
                            content: DateSelector(
                              datepicker: CupertinoDatePicker(
                                  initialDateTime: checkindate,
                                  minimumDate: checkindate,
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
                                print("checkindate " + checkoutdate.toString());
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
                        data: GetBuilder<BookingPageController>(builder: (_) {
                          return Center(
                            child: Text(
                              DateFormat('EEE, M/d/y')
                                  .format(bookingPageController.currentDateout)
                                  .toString(),
                            ),
                          );
                        })),
                    ReservationDateInputField(
                      hintcolor:
                          timeoutcolor ? Colors.black54 : Colors.redAccent,
                      size: size.width * 0.3,
                      hintText: "Select Check-Out Time *",
                      data: GetBuilder<BookingPageController>(
                        builder: (_) {
                          return Center(
                            child: Text(
                              DateFormat('hh:mm a')
                                  .format(bookingPageController.currentTimeout)
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
                              bookingPageController.updateTimeout(checkouttime);
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
                  padding: const EdgeInsets.only(top: 20.0, left: 0),
                  child: Column(
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
                          height: MediaQuery.of(context).size.height / 9,
                          // padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: variables.serviceIcon.length,
                              itemBuilder: (context, index) {
                                print("this is what i am printing...." +
                                    variables.serviceIcon[index].toString());
                                return ServicesCard(
                                  serviceIcon:
                                      variables.serviceIcon[index].toString(),
                                  servicesname: variables.servicesName[index],
                                );
                              })),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, top: 40),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Mutation(
                            options: MutationOptions(
                              document:
                                  gql(ResevationMutation().reservationmutation),
                              update: (GraphQLDataProxy cache,
                                  QueryResult? result) {
                                if (!result!.hasException) {
                                  Get.defaultDialog(
                                    confirm: RoundedButton5(
                                      text: "Pay now",
                                      press: () {
                                        Navigator.pop(context);
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.255,
                                    ),
                                    cancel: RoundedButton5(
                                      text: "Dismiss",
                                      press: () {
                                        Navigator.pop(context);
                                        Get.snackbar("Success",
                                            "You have created reservation successfully ",
                                            snackPosition: SnackPosition.TOP,
                                            colorText: bgcolor,
                                            backgroundColor: Colors.white,
                                            borderColor: bgcolor,
                                            duration: Duration(seconds: 1),
                                            animationDuration:
                                                Duration(seconds: 1),
                                            borderRadius: 15,
                                            borderWidth: 2.5);
                                      },
                                      color: bgcolor,
                                      size: size.width * 0.255,
                                    ),
                                    contentPadding: EdgeInsets.all(0),
                                    titlePadding: EdgeInsets.all(0),
                                    title: "Reservation Success",
                                    titleStyle: TextStyle(
                                        color: bgcolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    content: ReservationDialogue(),
                                    backgroundColor: kPrimaryLightColor,
                                  );
                                  print('finished lgg');
                                }
                                return cache;
                              },
                              onCompleted: (dynamic resultData) {
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
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: bgcolor, width: 2),
                                        color: kPrimaryLightColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 400,
                                      width: MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        title: Text(
                                            "Warning,can't create reservation"),
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
                                              color: bgcolor, width: 2),
                                          color: kPrimaryLightColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: SingleChildScrollView(
                                          child: Center(
                                            child: AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(2),
                                              titlePadding:
                                                  EdgeInsets.only(bottom: 10),
                                              title: AutoSizeText(
                                                "Warning,can't create reservation",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              content: Text(
                                                  "please ,check ur internet connection or enter the reservation date and time properly."),
                                              actions: [
                                                InkWell(
                                                  child: Container(
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: bgcolor,
                                                            width: 2),
                                                        color:
                                                            kPrimaryLightColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                          child:
                                                              Text("Retry"))),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        FadePageRoute(
                                                            widget:
                                                                ReserveForm()));
                                                  },
                                                )
                                              ],
                                            ),
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
                              return GetBuilder<BookingPageController>(
                                  builder: (_) {
                                return RoundedButton5(
                                  press: () {
                                    runMutation({
                                      'roomId':
                                          variables.roomsId[widget.roomindex],
                                      'hotelId': variables.hotelid,
                                      'checkin_time':
                                          DateFormat('EEE MMM dd yyyy ')
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
                                      'checkout_time':
                                          DateFormat('EEE MMM dd yyyy')
                                                  .format(
                                                      bookingPageController
                                                          .currentDateout) +
                                              " " +
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
                                  size: size.width * 0.4,
                                );
                              });
                            }),
                        SizedBox(
                          width: 25,
                        ),
                        Mutation(
                            options: MutationOptions(
                              document:
                                  gql(ResevationMutation().reservationmutation),
                              update: (GraphQLDataProxy cache,
                                  QueryResult? result) {
                                String reservation =
                                    result!.data?['login']['token'];
                                if (!result.hasException) {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => PaymentScreen(
                                  //           reservationid: "",
                                  //           price: widget.price,
                                  //           roomno: widget.roomno,
                                  //           floorno: widget.floorno)),
                                  // );
                                  Get.snackbar("coming soon ",
                                      "We are working on booking feature, it will be on the next version of the app",
                                      snackPosition: SnackPosition.TOP,
                                      colorText: bgcolor,
                                      backgroundColor: Colors.white,
                                      borderColor: bgcolor,
                                      duration: Duration(seconds: 1),
                                      animationDuration: Duration(seconds: 1),
                                      borderRadius: 15,
                                      borderWidth: 2.5);
                                  print('finished lgg');
                                }
                                return cache;
                              },
                              onCompleted: (dynamic resultData) {
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
                                    backwidget: ReserveForm(),
                                  );
                                } else {
                                  return ErrorPage2(
                                    backwidget: ReserveForm(),
                                    messagetext: message ?? "",
                                  );
                                }
                              }
                              return GetBuilder<BookingPageController>(
                                  builder: (_) {
                                return RoundedButton5(
                                  press: () {
                                    runMutation({
                                      'roomId':
                                          variables.roomsId[widget.roomindex],
                                      'hotelId': variables.hotelid,
                                      'checkin_time':
                                          DateFormat('EEE MMM dd yyyy ')
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
                                      'checkout_time':
                                          DateFormat('EEE MMM dd yyyy')
                                                  .format(
                                                      bookingPageController
                                                          .currentDateout) +
                                              " " +
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
                                  text: 'Book',
                                  color: bgcolor,
                                  size: size.width * 0.4,
                                );
                              });
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
