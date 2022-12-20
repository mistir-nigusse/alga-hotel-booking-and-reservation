import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class ResevationDropDown extends StatefulWidget {
  ResevationDropDown({Key? key}) : super(key: key);

  @override
  _ResevationDropDownState createState() => _ResevationDropDownState();
}

class _ResevationDropDownState extends State<ResevationDropDown> {
  final VariablesController variableController = Get.put(VariablesController());
  String? temp;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: bgcolor, width: 2),
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          DropdownButton(
            value: temp,
            icon: Icon(Icons.keyboard_arrow_down),
            items: variableController.roomno.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(items)));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                temp = newValue;
              });
            },
            hint: Text('Select Room'),
          ),
        ],
      ),
    );
  }
}
