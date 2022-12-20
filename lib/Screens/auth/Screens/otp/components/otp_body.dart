import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_box/verification_box.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/user_data.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/HomePage/homepage.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/otp/components/size_config.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/otp/otp_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class OTPBody extends StatefulWidget {
  final String email;
  final String firstname;
  final String middlename;
  final String lastname;
  final String phoneno;
  final String nationality;
  // final String image;

  OTPBody({
    Key? key,
    required this.email,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.phoneno,
    required this.nationality,
    //  required this.image
  }) : super(key: key);

  @override
  _OTPBodyState createState() => _OTPBodyState();
}

class _OTPBodyState extends State<OTPBody> {
  String? message;

  String mutation = """
  mutation(\$registrationCode: Int,\$registrationemail: String){
registration(code: \$registrationCode,email:\$registrationemail) {
  createdAt
  email
  token
  firstName
  middleName
  lastName
  phone_no

  }
}
  """;

  final VariablesController variables = Get.put(VariablesController());
  TextEditingController emailController = TextEditingController();
  final User usercontroller = Get.put(User());

  @override
  Widget build(BuildContext context) {
    String token = "";
    return Scaffold(
      body: Mutation(
          options: MutationOptions(
            document: gql(mutation),
            update: (GraphQLDataProxy cache, QueryResult? result) {
              variables.setToken(result!.data?['registration']['token']);
              usercontroller.setUserData(
                result.data?['registration']['firstName'],
                result.data?['registration']['middleName'],
                result.data?['registration']['lastName'],
                (result.data?['registration']['phone_no']).toString(),
                "",
                result.data?['registration']['email'],
              );
              if (!result.hasException) {
                print('finished otp');
                Navigator.push(
                    context,
                    FadePageRoute(
                        widget: Homepage(
                      token: token,
                    )));
                Get.snackbar("Success", "You have Registerd successfully ",
                    snackPosition: SnackPosition.TOP,
                    colorText: bgcolor,
                    backgroundColor: Colors.white,
                    borderColor: bgcolor,
                    duration: Duration(seconds: 1),
                    animationDuration: Duration(seconds: 1),
                    borderRadius: 15,
                    borderWidth: 2.5);
              }
              return cache;
            },
            onCompleted: (dynamic resultData) {},
            onError: (error) {
              //print(error);
              setState(() {
                message = error!.graphqlErrors[0].message;
              });
            },
          ),
          builder: (
            RunMutation runMutation,
            QueryResult? result,
          ) {
            if (result!.isLoading) {
              return Center(child: CircularProgressIndicator(color: bgcolor));
            }
            if (result.hasException) {
              if (result.exception!.linkException != null) {
                return ErrorPage(
                  backwidget: OtpScreen(
                    email: widget.email,
                    firstname: widget.firstname,
                    middlename: widget.middlename,
                    lastname: widget.lastname,
                    phoneno: widget.phoneno,
                    nationality: widget.nationality,
                    //  image: widget.image,
                  ),
                );
              } else {
                return ErrorPage2(
                  backwidget: OtpScreen(
                    email: widget.email,
                    firstname: widget.firstname,
                    middlename: widget.middlename,
                    lastname: widget.lastname,
                    phoneno: widget.phoneno,
                    nationality: widget.nationality,
                    // image: widget.image,
                  ),
                  messagetext: message ?? "",
                );
              }
            }
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.15),
                      Text(
                        "Account verification ",
                        style: headingStyle,
                      ),
                      Text("We have sent a 4 digit code to your email"),
                      TextFormField(
                        inputFormatters: [
                          new FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z]")),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: kPrimaryColor),
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.text,
                        initialValue: widget.email,
                        enabled: false,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.mail,
                            color: kPrimaryColor,
                          ),
                          hintStyle: TextStyle(color: kPrimaryColor),
                          hintText: "Your email",
                          border: InputBorder.none,
                        ),
                      ),
                      Column(
                        children: [
                          Text("Enter Your Confirmation Code"),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 45,
                            child: VerificationBox(
                              count: 4,
                              borderColor: bgcolor,
                              borderWidth: 3,
                              borderRadius: 50,
                              type: VerificationBoxItemType.underline,
                              textStyle: TextStyle(color: bgcolor),
                              showCursor: true,
                              cursorWidth: 2,
                              cursorColor: bgcolor,
                              cursorIndent: 10,
                              cursorEndIndent: 10,
                              focusBorderColor: bgcolor.withOpacity(0.4),
                              onSubmitted: (value) {
                                runMutation({
                                  'registrationCode': int.parse(value),
                                  'registrationemail': widget.email
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight / 7),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// ignore: must_be_immutable

