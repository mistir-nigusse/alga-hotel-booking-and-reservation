import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class User extends GetxController {
  late String FirstName;
  late String MiddleName;
  late String LastName;
  late String Email;
  late String password;
  late String phoneNo;
  //  late String image;

  final UserStorage = GetStorage();

  void setUserData(String firstname, String middlename, String lastname,
      String email, String password, String phoneNo) {
    UserStorage.write('firstname', firstname);
    UserStorage.write('middlename', middlename);
    UserStorage.write('lastname', lastname);
    UserStorage.write('email', email);
    UserStorage.write('password', password);
    UserStorage.write('phoneNo', phoneNo);
    //   UserStorage.write('image', image);
    update();
  }

  void editUserData(String firstname, String middlename, String lastname,
      String phoneNo, String image) {
    UserStorage.write('firstname', firstname);
    UserStorage.write('middlename', middlename);
    UserStorage.write('lastname', lastname);
    UserStorage.write('phoneNo', phoneNo);
    //UserStorage.write('image', image);
  }

  String getFirstName() {
    return UserStorage.read('firstname');
  }

  String getMiddleName() {
    return UserStorage.read('middlename');
  }

  String getLastName() {
    return UserStorage.read('lastname');
  }

  String getEmail() {
    return UserStorage.read('email');
  }

  String getpassword() {
    return UserStorage.read('password');
  }

  String getPhonno() {
    return UserStorage.read('phoneNo');
  }

  String getImage() {
    return UserStorage.read('image');
  }
}
