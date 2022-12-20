import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/text_field_container.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class RoundedNumberInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter>? inputformatter;
  final FormFieldValidator<String> validator;
  const RoundedNumberInputField({
    key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.controller,
    this.inputformatter,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        inputFormatters: inputformatter,
        style: TextStyle(color: kPrimaryColor),
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintStyle: TextStyle(color: kPrimaryColor),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
