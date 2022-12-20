import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/cybersource_query.dart';

class PaymentScreen extends StatelessWidget {
  final price;
  final roomno;
  final floorno;
  final reservationid;
  const PaymentScreen(
      {Key? key, this.price, this.roomno, this.floorno, this.reservationid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(
                        child: Text(
                      'Abel  yoni  ermi ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText('You are booking'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(child: AutoSizeText(' Room No')),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(child: AutoSizeText('Floor No')),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AutoSizeText('with price of'),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Center(
                  child: AutoSizeText(
                '1000 birr / night ',
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            ),
            SizedBox(
              height: 25,
            ),
            AutoSizeText(
              'Complete Action with',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(40),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Query(
                                    options: QueryOptions(
                                        document: gql(CybersourceQuery()
                                            .cybersourcequery),
                                        variables: {
                                          'price': price,
                                          'reservationId': reservationid,
                                          'Redirect_url': "",
                                          'paymentMethod': "master",
                                        }),
                                    builder: (QueryResult result,
                                        {VoidCallback? refetch,
                                        FetchMore? fetchMore}) {
                                      if (result.hasException) {
                                        if (result.exception!.linkException !=
                                            null) {
                                          return ErrorPage(
                                              backwidget: PaymentScreen());
                                        } else {
                                          return ErrorPage2(
                                            backwidget: PaymentScreen(),
                                            messagetext: result.exception!
                                                .graphqlErrors[0].message,
                                          );
                                        }
                                      }

                                      if (result.isLoading) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                                color: bgcolor));
                                      }

                                      return Container();
                                    }),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://dashenbanksc.com/wp-content/uploads/Amole-Payment-Services-Dashen-Bank-1.jpg')),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Query(
                                    options: QueryOptions(
                                        document: gql(CybersourceQuery()
                                            .cybersourcequery),
                                        variables: {
                                          'price': price,
                                          'reservationId': reservationid,
                                          'Redirect_url': "",
                                          'paymentMethod': "visa",
                                        }),
                                    builder: (QueryResult result,
                                        {VoidCallback? refetch,
                                        FetchMore? fetchMore}) {
                                      if (result.hasException) {
                                        if (result.exception!.linkException !=
                                            null) {
                                          return ErrorPage(
                                              backwidget: PaymentScreen());
                                        } else {
                                          return ErrorPage2(
                                            backwidget: PaymentScreen(),
                                            messagetext: result.exception!
                                                .graphqlErrors[0].message,
                                          );
                                        }
                                      }

                                      if (result.isLoading) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                                color: bgcolor));
                                      }

                                      return Container();
                                    }),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://dashenbanksc.com/wp-content/uploads/Amole-Payment-Services-Dashen-Bank-1.jpg')),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://dashenbanksc.com/wp-content/uploads/Amole-Payment-Services-Dashen-Bank-1.jpg')),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://dashenbanksc.com/wp-content/uploads/Amole-Payment-Services-Dashen-Bank-1.jpg')),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
