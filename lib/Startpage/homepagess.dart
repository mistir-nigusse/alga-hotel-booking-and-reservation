import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/welcome_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Startpage/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter OnBoarding Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
      routes: {
        'home': (context) => WelcomeScreen(),
        'onboard': (context) => const onBoardingPage(),
      },
    );
  }
}
