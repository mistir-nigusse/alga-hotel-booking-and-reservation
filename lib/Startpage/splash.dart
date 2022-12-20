import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/welcome_screen.dart';

class onBoardingPage extends StatelessWidget {
  const onBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: ' ',
          body: "WELCOME TO ALGA APP ",
          //   'Enjoy your favorite cuisine at your couch watch your favorite TV Show',
          image: Image.asset(
            'assets/images/sp3.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: ' ',
          body: 'Book Now and get your Room Key',
          image: Image.asset(
            'assets/images/sp2.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: ' ',
          body: ' Find Hotels around You ',
          image: Image.asset(
            'assets/images/splash4.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: ' ',
          body: ' Make Your Night With Just Your Fingertip ',
          image: Image.asset(
            'assets/images/sp1.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          decoration: buildDecoration(),
        ),
      ],
      next: const Icon(
        Icons.navigate_next,
        size: 35,
        color: Color.fromARGB(255, 11, 124, 90),
      ),
      done: const Text('Done',
          style:
              TextStyle(color: Color.fromARGB(255, 11, 124, 90), fontSize: 20)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Color.fromARGB(255, 11, 124, 90), fontSize: 20),
      ), //by default, skip goes to the last page
      onSkip: () => goToHome(context),
      dotsDecorator: getDotDecoration(),
      animationDuration: 1000,
      globalBackgroundColor: Colors.white,
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.grey,
      size: const Size(10, 10),
      activeColor: bgcolor,
      activeSize: const Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));

  void goToHome(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeScreen()));

  Widget buildImage(String path) => Image.asset(path);

  PageDecoration buildDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 89, 128, 116)),
        bodyTextStyle: const TextStyle(
            fontSize: 35,
            color: Color.fromARGB(255, 82, 131, 116),
            fontWeight: FontWeight.w700),
        pageColor: Colors.white,
        imagePadding: const EdgeInsets.all(0),
      );
}
