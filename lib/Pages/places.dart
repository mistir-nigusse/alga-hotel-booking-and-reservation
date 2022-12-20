import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Components/places_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/places_detail.dart';
import '../Costants/constants.dart';

class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    List<String> cities = [
      "Addis Ababa",
      "DireDawa",
      "Oromia",
      "South West Ethiopia",
      "Sidama",
      "SNNP",
      "Amhara",
      "Somali",
      "Afar",
      "Tigray",
      "Gambela",
      "Benshangul Gumuz",
      "Harari",
    ];
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddin,
            ),
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
              child: GridView.builder(
                  // shrinkWrap: true,
                  itemCount: cities.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                    maxCrossAxisExtent: 140,
                  ),
                  itemBuilder: (context, index) {
                    return Placescard(
                      image:
                          "http://157.230.190.157/static/media/Alga-logo.7447e436.png",
                      title: cities[index],
                      press: () {
                        Get.to(() => PlacesDetails(
                              title: cities[index].toString(),
                            ));
                      },
                    );
                  }),
            )));
  }
}
