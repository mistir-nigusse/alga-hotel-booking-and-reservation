import 'package:get/get.dart';

class BookingPageController extends GetxController {
  DateTime currentDatein = DateTime?.now();
  DateTime currentDateout = DateTime?.now();
  DateTime curentTimein = DateTime.now();
  DateTime currentTimeout = DateTime.now();
  late DateTime initialOut;
  void updateDateIn(DateTime pickedDate) {
    currentDatein = pickedDate;
    initialOut = pickedDate;
    update();
  }

  void updateDateOut(DateTime pickedDate) {
    currentDateout = pickedDate;
    update();
  }

  void updateTimeIn(DateTime pickedTime) {
    curentTimein = pickedTime;
    update();
  }

  void updateTimeout(DateTime pickedTime) {
    currentTimeout = pickedTime;
    update();
  }
}
