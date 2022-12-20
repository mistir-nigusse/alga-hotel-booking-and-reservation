import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VariablesController extends GetxController {
  late String token;
  late dynamic hotelid;
  late int hotelindex;
  List<String> roomno = [];
  List<int> floorno = [];
  late List<String> roomsId;
  late List<String> servicesName;
  late List<int> servicesPrice = [];
  late List<String> history = [];
  late List<String> secondhistory = [];

  final searchhistorystorage = GetStorage();
  final tokenstorage = GetStorage();
  final radiusStorage = GetStorage();

  void setRadius(String newradius) {
    double rad = double.parse(newradius);
    radiusStorage.write('radius', rad);
    update();
  }

  double getRadius() {
    return radiusStorage.read('radius') ?? 1.0;
  }

  late List<String> serviceIcon;
  void setserviceIcon(List<String> icons) {
    serviceIcon = icons;
    update();
  }

  void setToken(String newtoken) {
    token = newtoken;
    tokenstorage.write('token', newtoken);
    update();
  }

  String getoken() {
    return tokenstorage.read('token') ?? "";
  }

  void setHotelid(dynamic id) {
    hotelid = id;
    update();
  }

  void sethotelIndex(int index) {
    hotelindex = index;
    update();
  }

  void setroomsid(List<String> roomsid) {
    roomsId = roomsid;
    update();
  }

  void setroomsno(List<String> roomsno) {
    roomno = roomsno;
    update();
  }

  void setfloorno(List<int> floorsno) {
    floorno = floorsno;
    update();
  }

  void setservicename(List<String> names) {
    servicesName = names;
    update();
  }

  void setservicePrice(List<int> price) {
    servicesPrice = price;
    update();
  }

  void sethistory(String searchednames) {
    history.add(searchednames);

    searchhistorystorage.write('search-history', history);

    update();
  }

  List<dynamic> gethistory() {
    if (searchhistorystorage.hasData('search-history')) {
      List<dynamic> newhistory = new List<dynamic>.from(
          searchhistorystorage.read('search-history'),
          growable: true);
      return newhistory;
    } else {
      return history;
    }
  }
}
