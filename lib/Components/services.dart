import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard(
      {Key? key, required this.servicesname, required this.serviceIcon})
      : super(key: key);
  final String servicesname;
  final String serviceIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 28,
              child: FadeInImage(
                image: NetworkImage(
                  serviceIcon,
                ),
                placeholder: AssetImage("assets/icons/logo.png"),
                fit: BoxFit.fill,
              )),
          Text(
            servicesname,
            style: TextStyle(
                fontSize: 18, color: bgcolor, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
