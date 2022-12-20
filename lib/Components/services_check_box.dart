import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class ServicesCheckBox extends StatefulWidget {
  const ServicesCheckBox({Key? key}) : super(key: key);

  @override
  _ServicesCheckBoxState createState() => _ServicesCheckBoxState();
}

class _ServicesCheckBoxState extends State<ServicesCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      return bgcolor;
    }

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Food Delivery",
            style: TextStyle(
                fontWeight: FontWeight.w400, color: bgcolor, fontSize: 15),
          ),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
