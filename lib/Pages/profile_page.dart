import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Components/main_layout3.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/edit_profile.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/profile_query.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/welcome_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/reset_password.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final VariablesController variableController = Get.put(VariablesController());

  @override
  Widget build(BuildContext context) {
    HttpLink httpLink = HttpLink(
      'http://157.230.190.157/graphql',
      defaultHeaders: <String, String>{
        'Authorization': 'Bearer ${variableController.getoken()}',
      },
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    double paddingttop = MediaQuery.of(context).size.height / 9;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
          drawer: Mydrawer(),
          backgroundColor: Color(0xffF9F9F9),
          body: Query(
              options: QueryOptions(
                document: gql(ProfileQuery().profilequery),
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  if (result.exception!.linkException != null) {
                    return ErrorPage(
                      backwidget: ProfilePage(),
                    );
                  } else {
                    return ErrorPage2(
                      backwidget: ProfilePage(),
                      messagetext: result.exception!.graphqlErrors[0].message,
                    );
                  }
                }

                if (result.isLoading) {
                  return Center(
                      child: CircularProgressIndicator(color: bgcolor));
                }
                return Stack(
                  children: [
                    Container(
                      child: ClipPath(
                        clipper: MyClipper2(),
                        child: Container(
                          color: bgcolor,
                          height: MediaQuery.of(context).size.height / 4.3,
                        ),
                      ),
                    ),
                    SafeArea(
                      top: true,
                      child: SingleChildScrollView(
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: paddingttop),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: result.data?['viewProfile']
                                    ['image'],
                                backgroundColor: Colors.white,
                                maxRadius: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: AutoSizeText(
                                        result.data?['viewProfile']
                                                ['firstName'] +
                                            ' ' +
                                            result.data?['viewProfile']
                                                ['middleName'] +
                                            ' ' +
                                            result.data?['viewProfile']
                                                ['lastName'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.email_outlined),
                                            onPressed: () {}),
                                        Text(
                                          'E-mail: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Text(
                                            result.data?['viewProfile']
                                                ['email'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.phone),
                                            onPressed: () {}),
                                        Text(
                                          'Phone No :',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "+251 " +
                                              result.data!['viewProfile']
                                                      ['phone_no']
                                                  .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.flag),
                                            onPressed: () {}),
                                        Text(
                                          'Nationality :',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            result.data?['viewProfile']
                                                ['nationality'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                                Icons.location_on_outlined),
                                            onPressed: () {}),
                                        Text(
                                          'Address :',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Bole road Addis Ababa ,Ethiopia',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              RoundedButton4(
                                  widthsize:
                                      MediaQuery.of(context).size.width * 0.8,
                                  text: "Change Password",
                                  press: () {
                                    Navigator.push(context,
                                        FadePageRoute(widget: ResetPassword()));
                                  },
                                  color: bgcolor)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 50.0, right: 40.0),
                        child: FloatingActionButton(
                          backgroundColor: bgcolor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                FadePageRoute(
                                    widget: EditProfile(
                                        image: result.data?['viewProfile']
                                            ['image'],
                                        fName: result.data?['viewProfile']
                                            ['firstName'],
                                        mName: result.data?['viewProfile']
                                            ['middleName'],
                                        lName: result.data?['viewProfile']
                                            ['lastName'],
                                        phoneNo: result.data!['viewProfile']
                                            ['phone_no'])));
                          },
                          tooltip: 'Edit Profile',
                          child: IconButton(
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  FadePageRoute(
                                      widget: EditProfile(
                                          image: result.data?['viewProfile']
                                              ['image'],
                                          fName: result.data?['viewProfile']
                                              ['firstName'],
                                          mName: result.data?['viewProfile']
                                              ['lastName'],
                                          lName: result.data?['viewProfile']
                                              ['lastName'],
                                          phoneNo: result.data?['viewProfile']
                                              ['phone_no'])));
                            },
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Container(
                          height: MediaQuery.of(context).size.height / 14,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Builder(
                                    builder: (con) => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: IconButton(
                                            icon: Icon(
                                              CupertinoIcons.list_dash,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                            onPressed: () =>
                                                Scaffold.of(con).openDrawer(),
                                          ),
                                        )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.logout,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      variableController.tokenstorage
                                          .remove('token');
                                      Navigator.pushReplacement(
                                          context,
                                          FadePageRoute(
                                              widget: WelcomeScreen()));
                                      Get.snackbar("Success",
                                          "You have Edited your reservation successfully ",
                                          snackPosition: SnackPosition.TOP,
                                          colorText: bgcolor,
                                          backgroundColor: Colors.white,
                                          borderColor: bgcolor,
                                          duration: Duration(seconds: 1),
                                          animationDuration:
                                              Duration(seconds: 1),
                                          borderRadius: 15,
                                          borderWidth: 2.5);
                                    }),
                              )
                            ],
                          )),
                    ),
                  ],
                );
              })),
    );
  }
}
