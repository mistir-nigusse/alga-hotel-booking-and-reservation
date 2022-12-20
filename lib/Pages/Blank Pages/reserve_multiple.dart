import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

import '../../Screens/auth/components/input_field.dart';
import '../../Screens/auth/components/rounded_number_input_field.dart';

class ReserveMultipleForm extends StatefulWidget {
  var selectedRoomList;
  ReserveMultipleForm({Key? key, this.selectedRoomList}) : super(key: key);

  @override
  State<ReserveMultipleForm> createState() => _ReserveMultipleFormState();
}

class _ReserveMultipleFormState extends State<ReserveMultipleForm> {
  String? message;
  @override
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
  late TextEditingController companyNameController = TextEditingController(),
      emailController = TextEditingController();

  // var guestInfo = [];

  //  String firstName = " ", lastName = " ", middleName = " ", phoneno = " ";

  Widget build(BuildContext context) {
    var totalGuests = [];

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              //company info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Company Detail",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RoundedInputField(
                  inputformatter: [
                    new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter company name';
                    }
                    return null;
                  },
                  hintText: "Enter company name *",
                  onChanged: (value) {},
                  controller: companyNameController),
              RoundedInputField(
                  icon: Icons.mail,
                  hintText: "Your company Email *",
                  onChanged: (value) {},
                  controller: emailController,
                  validator: (value) {
                    if (!GetUtils.isEmail(value!)) {
                      return "Provide valid Email";
                    }
                    return null;
                  }),

              SizedBox(
                height: 10,
              ),
              // chekck in and check out time
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
                              bookingPageController.updateDateOut(checkoutdate);
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
                    hintcolor: timeoutcolor ? Colors.black54 : Colors.redAccent,
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
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.selectedRoomList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (BuildContext context, int index) {
                    var guestNumber = index;
                    guestNumber = ++guestNumber;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),

                        /*
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "Guest $guestNumber info",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter First name';
                            }
                            return null;
                          
                          },
                          hintText: " First Name *",
                          onChanged: (value) {
                            setState(() {
                              totalGuests[index][0] = value;
                            });
                          },
                          //  controller: firstNameControllers[index]
                        ),
                        InputField(
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Middle name';
                            }
                            return null;
                          },
                          hintText: " Middle Name *",
                          onChanged: (value) {
                            setState(() {
                              totalGuests[index][1] = value;
                            });
                          },
                          // controller: middleNameControllers[index]
                        ),
                        InputField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Last name';
                            }
                            return null;
                          },
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          hintText: " Last Name *",
                          onChanged: (value) {
                            setState(() {
                              totalGuests[index][2] = value;
                            });
                          },
                          //    controller: lastNameControllers[index],
                        ),
                        InputField(
                          validator: (value) {
                            if (!GetUtils.isPhoneNumber(value!)) {
                              return "Provide valid Phone Number";
                            }
                            return null;
                          },
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                          ],
                          //  controller: phonenoControllers[index],
                          icon: Icons.phone,
                          hintText: "Phone.No *",
                          onChanged: (value) {
                            setState(() {
                              totalGuests[index][3] = value;
                            });
                          },
                        ),
                        ReservationInputField(
                          size: size.width * 0.7,
                          hintText: "Nationality",
                          icon: Icons.person,
                          DataText: 'Ethiopian',
                        ),
                       */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReservationInputField(
                              size: size.width * 0.4,
                              hintText: "Room No",
                              icon: Icons.hotel,
                              DataText:
                                  widget.selectedRoomList[index][3].toString(),
                            ),
                            ReservationInputField(
                                size: size.width * 0.4,
                                hintText: "Floor No",
                                icon: CupertinoIcons.building_2_fill,
                                DataText: widget.selectedRoomList[index][0]
                                    .toString()),
                          ],
                        ),
                      ],
                    );
                  }),

              //users info

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

                    // services

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
                            document: gql(ResevationMutation()
                                .companyReservationMutation),
                            update:
                                (GraphQLDataProxy cache, QueryResult? result) {
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
                                      border:
                                          Border.all(color: bgcolor, width: 2),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: MediaQuery.of(context).size.width /
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
                                                      color: kPrimaryLightColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                        child: Text("Retry"))),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      FadePageRoute(
                                                          widget:
                                                              ReserveMultipleForm()));
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
                                  var roomList = [];

                                  for (int i = 0;
                                      i < widget.selectedRoomList.length;
                                      i++) {
                                    //  totalGuests.add(guestInfo);
                                    roomList.add(widget.selectedRoomList[0][4]
                                        .toString());
                                  }
                                  print(companyNameController.text +
                                      emailController.text +
                                      roomList.toString() +
                                      variables.hotelid);
                                  runMutation({
                                    'companyName': companyNameController.text,
                                    'companyEmail': emailController.text,
                                    'roomId': roomList,
                                    'hotelId': variables.hotelid,
                                    'checkin_time':
                                        DateFormat('EEE MMM dd yyyy ').format(
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
                                        DateFormat('EEE MMM dd yyyy').format(
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
                            update:
                                (GraphQLDataProxy cache, QueryResult? result) {
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
                                  backwidget: ReserveMultipleForm(),
                                );
                              } else {
                                return ErrorPage2(
                                  backwidget: ReserveMultipleForm(),
                                  messagetext: message ?? "",
                                );
                              }
                            }
                            return GetBuilder<BookingPageController>(
                                builder: (_) {
                              return RoundedButton5(
                                press: () {
                                  for (int i = 0;
                                      i <= widget.selectedRoomList.length;
                                      i++) {
                                    runMutation({
                                      'roomId': variables.roomsId[
                                          widget.selectedRoomList[i][5]],
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
                                  }
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
    );
  }
}
