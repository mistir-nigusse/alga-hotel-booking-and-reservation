import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: TextStyle(color: bgcolor),
        ),
        leading: Builder(
            builder: (con) => IconButton(
                  icon: Icon(
                    CupertinoIcons.arrow_left_circle,
                    color: bgcolor,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                )),
      ),
      // drawer: Mydrawer(),
    );
  }
}
