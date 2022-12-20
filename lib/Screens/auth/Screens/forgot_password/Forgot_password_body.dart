import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/no_internet.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  String mutation = """
  mutation(\$forgetPasswordEmail: String){
  forgetPassword(email: \$forgetPasswordEmail) {
    message
  }
}
  """;
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? message;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Mutation(
        options: MutationOptions(
          document: gql(mutation),
          update: (GraphQLDataProxy cache, QueryResult? result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            Navigator.pop(context);
            print('ggc');
          },
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
          if (result!.hasException) {
            if (result.exception!.linkException != null) {
              return ErrorPage(
                backwidget: ForgotPassword(),
              );
            } else {
              return ErrorPage2(
                backwidget: ForgotPassword(),
                messagetext: message ?? "",
              );
            }
          }
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
                            ? Center(
                                child: Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: size.height * 0.03),
                                      SizedBox(height: size.height * 0.03),
                                      RoundedInputField(
                                        validator: (value) {
                                          return validateEmail(value!);
                                        },
                                        controller: emailController,
                                        hintText: "Enter your email",
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        "Please Enter your email to recover your account ",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 40.0),
                                        child: RoundedButton4(
                                            widthsize: size.width * 0.8,
                                            text: "Submit",
                                            press: () {
                                              if (result.data == null)
                                                runMutation({
                                                  'forgetPasswordEmail':
                                                      emailController.text,
                                                });
                                              Navigator.pop(context);
                                              Get.snackbar("Success",
                                                  "A Temporary password has been sent to your email, Please check Your Emial",
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  colorText: bgcolor,
                                                  backgroundColor: Colors.white,
                                                  borderColor: bgcolor,
                                                  duration:
                                                      Duration(seconds: 3),
                                                  animationDuration:
                                                      Duration(seconds: 1),
                                                  borderRadius: 15,
                                                  borderWidth: 2.5);
                                            },
                                            color: bgcolor),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                    ],
                                  ),
                                ),
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
        });
  }
}
