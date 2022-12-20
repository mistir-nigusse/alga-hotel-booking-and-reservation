import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Languages/localeString.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Login/login_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Signup/signup_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/components/background.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      // translation: LocalString(),
      // locale: Locale('En','Amh'),
      appBar: AppBar(
        backgroundColor: bgcolor2,
        bottomOpacity: 0.0,
        // toolbarOpacity: 0.0,
        title: Container(
          color: bgcolor2,
          child: IconButton(
            icon: Icon(
              Icons.language,
              size: 40,
              color: bgcolor,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comming Soon ...')));
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/icons/logo.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton4(
              widthsize: size.width * 0.8,
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              color: bgcolor,
            ),
            RoundedButton4(
              widthsize: size.width * 0.8,
              text: "Register",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
              color: bgcolor,
            ),
          ],
        ),
      ),
    );
  }
}

class Language {
  final int id;
  final String name;
  final String languageCode;
  Language(this.id, this.name, this.languageCode);
  static List<Language> languageList() {
    return <Language>[
      Language(1, "English", "En"),
      Language(2, "Amharic", "Amh"),
      Language(3, "Afaan Oromo", "Oro"),
      Language(4, "Af Soomali", "Som")
    ];
  }
}
