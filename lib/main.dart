import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Springboard_page.dart';
// import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      // 'http://192.168.1.9:5000/graphql',
      'http://157.230.190.157/graphql',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    return GraphQLProvider(
      client: client,
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Alga-አልጋ',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Springboardpage()),
    );
  }
}
