import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Fav extends GetxController {
  List<String> totalHotelsname = [];
  List<String> hotelnames = [];
  List<String> hotelurl = [];
  bool isselected = false;
  List<bool> selected = [];
  final favselection = GetStorage();
  final favhotelstorage = GetStorage();
  void selectfav() {
    selected.add(true);
    favselection.write('key', selected);
  }

  void notselectfav() {
    selected.add(false);
    favselection.write('key', selected);
  }

  void setHotelNames(String name) {
    hotelnames.add(name);
    favhotelstorage.write('name', hotelnames);

    update();
  }

  void settotalHotelNames(String name) {
    totalHotelsname.add(name);
    favhotelstorage.write('total', totalHotelsname);

    update();
  }

  List<dynamic> gettotalName() {
    if (favhotelstorage.hasData('total')) {
      List<dynamic> getname =
          new List<dynamic>.from(favhotelstorage.read('total'));
      return getname;
    } else {
      List<String> x = [];
      return x;
    }
  }

  void setHotelNurl(String url) {
    hotelurl.add(url);
    favhotelstorage.write('url', hotelurl);
    update();
  }

  List<dynamic> getName() {
    if (favhotelstorage.hasData('name')) {
      List<dynamic> getname =
          new List<dynamic>.from(favhotelstorage.read('name'));
      return getname;
    } else {
      List<String> x = [];
      return x;
    }
  }

  List<dynamic> geturl() {
    List<dynamic> getUrl = new List<dynamic>.from(favhotelstorage.read('url'));

    return getUrl;
  }
}
