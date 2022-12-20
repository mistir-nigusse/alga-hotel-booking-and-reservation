import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Placescard extends StatelessWidget {
  final Function press;
  final String title, image;
  const Placescard({
    Key? key,
    required this.press,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(
              // color: bgcolor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: bgcolor)),
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: FadeInImage.assetNetwork(
                        height: MediaQuery.of(context).size.height / 6.5,
                        width: MediaQuery.of(context).size.width / 2.3,
                        fit: BoxFit.fill,
                        placeholder: "assets/icons/logo.png",
                        image: image),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bgcolor,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
