import 'dart:async';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/map_query.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/homepage.dart';

class MapPagecontent extends StatefulWidget {
  final aboutImageUrl;
  final aboutHotelname;
  final aboutHoteldescription;
  final wereda;
  final state;
  final city;
  final email;
  final phoneNo;
  final hotelImageurl;
  final Function showposiononlist;
  final id;

  const MapPagecontent({
    Key? key,
    required this.aboutImageUrl,
    required this.aboutHotelname,
    required this.aboutHoteldescription,
    required this.wereda,
    required this.state,
    required this.city,
    required this.email,
    required this.phoneNo,
    required this.hotelImageurl,
    this.id,
    required this.showposiononlist,
  }) : super(key: key);

  @override
  _MapPagecontentState createState() => _MapPagecontentState();
}

class _MapPagecontentState extends State<MapPagecontent> {
  VariablesController variables = Get.put(VariablesController());
  static const CameraPosition initialposition =
      CameraPosition(target: LatLng(9.0373646, 38.7459161), zoom: 16);
  late GoogleMapController googleMapController;

  double lattude = 9.0373646;
  double longtude = 38.7459161;
  String textholder = "";
  Geolocator geolocator = Geolocator();
  // Location currentLocation = Location();
  final Set<Marker> markers = new Set();
  final Set<Marker> markers2 = new Set();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      lattude = position.latitude;
      longtude = position.longitude;
    });

    // LatLng lanlangposition = LatLng(lattude, longtude);
    // CameraPosition cameraPosition =
    //     new CameraPosition(target: lanlangposition, zoom: 17.5);
    // googleMapController
    //     .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // void getLocation() async {
  //   var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen((LocationData loc) {
  //     googleMapController
  //         ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //       zoom: 12.0,
  //     )));
  //     print(loc.latitude);
  //     print(loc.longitude);
  //     setState(() {
  //       markers.add(Marker(
  //           markerId: MarkerId('Me'),
  //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //     });
  //   });
  // }

  void showpos() {
    LatLng lanlangposition = LatLng(lattude, longtude);
    CameraPosition cameraPosition =
        new CameraPosition(target: lanlangposition, zoom: 17.5);
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void initState() {
    // locatePosition();
    super.initState();
    setState(() {
      locatePosition();
    });
  }

  TextEditingController radius = TextEditingController();

  List<LatLng> hotelsPosition = [];
  late int length1 = 0;
  bool x = false;
  List<String?> hotelsname = [];
  List<int> hotelstar = [];
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controllerGoogleMap = Completer();
    final HttpLink httpLink = HttpLink(
      'http://157.230.190.157/graphql',
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
        client: client,
        child: Query(
            options:
                QueryOptions(document: gql(MapQuery().mapQuery), variables: {
              'nearByHotelLat': lattude,
              'nearByHotelLong': longtude,
              'nearByHotelRadius': variables.getRadius()
            }),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                if (result.exception!.linkException != null) {
                  return ErrorPage(
                    backwidget: Homepage(
                      token: variables.getoken(),
                    ),
                  );
                } else {
                  return ErrorPage2(
                    backwidget: Homepage(
                      token: variables.getoken(),
                    ),
                    messagetext: result.exception!.graphqlErrors[0].message,
                  );
                }
              }

              if (result.isLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: bgcolor,
                ));
              }
              int hotelslength = result.data?['nearByHotel'].length;
              length1 = hotelslength;

              for (int i = 0; i < hotelslength; i++) {
                LatLng positions = LatLng(
                    result.data!['nearByHotel'][i]['address']['lat'],
                    result.data!['nearByHotel'][i]['address']['long']);
                hotelsPosition.add(positions);
                String? hotelname = result.data?['nearByHotel'][i]['name'];
                hotelsname.add(hotelname);
                int star = result.data?['nearByHotel'][i]['star'];
                hotelstar.add(star);
              }
              return Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF6F7FF),
                    boxShadow: [
                      BoxShadow(
                        color: bgcolor.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 9,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Stack(children: [
                  GoogleMap(
                      // markers: getmarkers(),
                      //x == false ? markers2 :

                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: initialposition,
                      onMapCreated: (GoogleMapController controller) {
                        if (!_controllerGoogleMap.isCompleted) {
                          _controllerGoogleMap.complete(controller);
                        } else {}
                        // _controllerGoogleMap.complete(controller);
                        googleMapController = controller;
                        // locatePosition();
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 30),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.my_location,
                                    size: 30,
                                    color: bgcolor,
                                  ),
                                  onPressed: () {
                                    showpos();
                                    Get.snackbar(
                                        "Loading...", "Getting Your Location",
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: bgcolor,
                                        backgroundColor: Colors.white,
                                        borderColor: bgcolor,
                                        duration: Duration(seconds: 3),
                                        animationDuration: Duration(seconds: 1),
                                        borderRadius: 15,
                                        borderWidth: 2.5);
                                    // widget.showposiononlist();
                                    // Get.bottomSheet(SliverNearBy());
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              );
            }));
  }

  getmarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/icons/logo.png");
    for (int i = 0; i < length1; i++) {
      int star = hotelstar[i];
      markers.add(Marker(
          markerId: MarkerId(hotelsPosition[i].toString()),
          position: LatLng(hotelsPosition[i].latitude,
              hotelsPosition[i].longitude), //position of marker
          infoWindow: InfoWindow(
            title: hotelsname[i],
            snippet: '$star star Hotel',
          ),
          icon: markerbitmap,
          onTap: () {
            int index = widget.aboutHotelname.indexOf(hotelsname[i]);
            variables.setHotelid(widget.id[index]);
            Get.to(() => TravelApp(
                  aboutHotelname: widget.aboutHotelname[index],
                  aboutHoteldescription: widget.aboutHoteldescription[index],
                  aboutImageUrl: widget.aboutImageUrl,
                  city: widget.city[index],
                  email: widget.email[index],
                  hotelImageurl: widget.hotelImageurl[index],
                  hotelName: widget.aboutHotelname[index],
                  phoneNo: widget.phoneNo[index],
                  roomTypescount: index,
                  state: widget.state[index],
                  wereda: widget.wereda[index],
                ));
          }));
      print(hotelsPosition[i].latitude);
      print(hotelsPosition[i].longitude);
    }
    return markers;
  }
}
