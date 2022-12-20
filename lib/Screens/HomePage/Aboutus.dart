import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "About Us",
          style: TextStyle(color: bgcolor),
        ),
        leading: Builder(
            builder: (con) => IconButton(
                  icon: Icon(CupertinoIcons.list_dash, color: bgcolor),
                  onPressed: () => Scaffold.of(con).openDrawer(),
                )),
      ),
      drawer: Mydrawer(),
      body: Center(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 350,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 8),
                      child: Text(
                          "Alga is a free hotel room booking application.  It enable users to reserve and book remotely.",
                          style: TextStyle(
                              color: bgcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          //  color: bgcolor,
                          Icons.place,
                          size: 18,
                          color: bgcolor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              " address : Ethiopia, Addis Ababa, \n megenagna 24 next to kokeb hall",
                              style: TextStyle(
                                  color: bgcolor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 18,
                          color: bgcolor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(" +251925002580/ \n +251943141717",
                              style: TextStyle(
                                  color: bgcolor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 18,
                          color: bgcolor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("contact@rcndc.com",
                              style: TextStyle(
                                  color: bgcolor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
