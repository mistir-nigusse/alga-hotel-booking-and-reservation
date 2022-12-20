import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/no_internet.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_list.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/favorites.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/map_page.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/profile_page.dart';

class Homepage extends StatefulWidget {
  final String token;
  Homepage({Key? key, required this.token}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _currentPage = 0;
  final _pages = [
    // MapPage(),
    Hotels(),
    Favorites(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              child,
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: connected
                      ? Scaffold(
                          drawer: Mydrawer(),
                          body: Center(
                            child: _pages[_currentPage],
                          ),
                          bottomNavigationBar: BottomNavigationBar(
                              elevation: 2,
                              backgroundColor: Color(0xFFF6F7FF),
                              items: [
                                /*  BottomNavigationBarItem(
                                    icon: Icon(
                                      CupertinoIcons.map,
                                      color: bgcolor,
                                      size: 30,
                                    ),
                                    label: ("Map")), */
                                BottomNavigationBarItem(
                                    backgroundColor: Color(0xFFF6F7FF),
                                    icon: Icon(CupertinoIcons.list_bullet,
                                        color: bgcolor, size: 30),
                                    label: ("Hotel List")),
                                BottomNavigationBarItem(
                                    icon: Icon(Icons.favorite_border_outlined,
                                        color: bgcolor, size: 30),
                                    label: ("Favorites")),
                                BottomNavigationBarItem(
                                    icon: Icon(Icons.account_circle_outlined,
                                        color: bgcolor, size: 32),
                                    label: ("Profile")),
                              ],
                              currentIndex: _currentPage,
                              fixedColor: bgcolor,
                              onTap: (int inIndex) {
                                setState(() {
                                  _currentPage = inIndex;
                                });
                              }),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: NoInternet()))
            ],
          );
        },
        child: Stack(
          children: [Container()],
        ));
  }
}
