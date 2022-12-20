import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/gallery_conatiner.dart';
//import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/rooms.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/gallery_query.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key, this.roomTypescount}) : super(key: key);
  final roomTypescount;
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return CatagoryDetailContent(
      roomTypescount: widget.roomTypescount,
    );
  }
}

class CatagoryDetailContent extends StatefulWidget {
  const CatagoryDetailContent({
    Key? key,
    this.roomTypescount,
  }) : super(key: key);
  final roomTypescount;
  @override
  _CatagoryDetailContentState createState() => _CatagoryDetailContentState();
}

class _CatagoryDetailContentState extends State<CatagoryDetailContent> {
  List<int> items = List<int>.generate(10, (int index) => index);

  VariablesController variables = Get.put(VariablesController());
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(GalleryQuery().galleryquery),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            if (result.exception!.linkException != null) {
              return ErrorPage(
                backwidget: Rooms(
                  roomTypescount: 0,
                ),
              );
            } else {
              return ErrorPage2(
                backwidget: Rooms(
                  roomTypescount: 0,
                ),
                messagetext: result.exception!.graphqlErrors[0].message,
              );
            }
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator(color: bgcolor));
          }
          List<String> urls = [];
          int photoCount = result
              .data?['userViewHotels'][widget.roomTypescount]['photos'].length;
          for (int i = 0; i < photoCount; i++) {
            String url = result.data?['userViewHotels'][widget.roomTypescount]
                ['photos'][i]['imageURI'];
            urls.add(url);
          }
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 1.0,
                  initialPage: 1,
                ),
                itemCount: urls.length,
                //padding: EdgeInsets.all(8.0),
                /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),*/
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return GalleryCard(
                    // press: () {},
                    urls: urls,
                    index: index,
                  );
                },
              ));
        });
  }
}
