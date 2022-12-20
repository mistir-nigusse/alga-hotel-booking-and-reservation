import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nearby_hotel_detction_booking_app/Components/edit_reservation_form.dart';
import 'package:nearby_hotel_detction_booking_app/Components/hotel_list_card_widget.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class HistoryBookedListCart extends StatelessWidget {
  final reserveId;
  final String hotelname;
  final roomNo;
  final createdAt;
  final floorno;
  final checkInDate;
  final checkOutDate;
  final services;
  final checkout;

  const HistoryBookedListCart({
    Key? key,
    this.reserveId,
    required this.hotelname,
    this.roomNo,
    this.createdAt,
    this.floorno,
    this.checkInDate,
    this.checkOutDate,
    this.services,
    this.checkout,
  }) : super(key: key);

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
                Get.bottomSheet(
                  EditReservationFormMinified(
                    bookingid: reserveId,
                  ),
                  isDismissible: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                );
              },
              icon: Icon(Icons.edit)),
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
