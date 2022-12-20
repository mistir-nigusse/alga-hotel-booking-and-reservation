import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/text_field_container.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String hinttext;
  const RoundedPasswordField({
    key,
    required this.controller,
    required this.validator,
    required this.hinttext,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool visibility = true;

  _RoundedPasswordFieldState();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: kPrimaryColor),
        obscureText: visibility,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: kPrimaryColor,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          focusColor: kPrimaryColor,
          fillColor: kPrimaryColor,
          hintText: widget.hinttext,
          hintStyle: TextStyle(color: kPrimaryColor),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visibility = !visibility;
                });
              },
              icon: Icon(
                visibility ? Icons.visibility : Icons.visibility_off,
                color: kPrimaryColor,
              )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
