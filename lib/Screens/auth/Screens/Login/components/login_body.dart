import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/user_data.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Login/components/temp_class.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Login/login_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/forgot_password/Forgot_password_body.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_password_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  void initState() {
    super.initState();
  }

  final VariablesController variables = Get.put(VariablesController());
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final String query = """
 query(\$loginPassword: String, \$loginUsername: String){
  login(password: \$loginPassword,username: \$loginUsername) {
   firstName
  middleName
  lastName
  phone_no
  email
  token
  }
}
""";
  final User usercontroller = Get.put(User());
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePhoneNo(String value) {
    if (!GetUtils.isPhoneNumber(value)) {
      return "Provide valid Phone Number";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }
    return null;
  }

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      print(!isValid);
      return false;
    } else {
      loginFormKey.currentState!.save();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    String token = '';
    String firstname = '';
    String middlename = '';
    String lastname = '';
    int phoneno;
    String email = '';
    //  String image;
    Size size = MediaQuery.of(context).size;

    // AppBar: appBar(

    //   child: DropdownButton<Language>(
    // underline: SizedBox(),
    // icon: Icon(
    //   Icons.language,
    //   color: bgcolor,
    // ),
    //   ),
    // );
    return SingleChildScrollView(
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Enter your Email or Phone No.",
              onChanged: (value) {},
              controller: usernameController,
              validator: (value) {
                if (GetUtils.isEmail(value!)) {
                  validateEmail(value);
                } else if (GetUtils.isPhoneNumber(value)) {
                  validatePhoneNo(value);
                } else
                  return "enter a valid User Name";
                return null;
              },
            ),
            RoundedPasswordField(
              controller: passwordController,
              validator: (value) {
                return validatePassword(value!);
              },
              hinttext: 'Your Password',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(
                    ForgotPassword(),
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  );
                  // Navigator.push(
                  //     context, FadePageRoute(widget: Forgotpassmain()));
                },
                child: Text(
                  "I forgot My password ",
                  style: TextStyle(color: kPrimaryColor, fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton4(
                    text: "Back",
                    press: () {
                      Navigator.pop(context);
                    },
                    color: bgcolor,
                    widthsize: size.width * 0.3),
                RoundedButton4(
                  widthsize: size.width * 0.4,
                  text: "LOGIN",
                  press: () {
                    bool x = checkLogin();
                    if (x) {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Query(
                                    options: QueryOptions(
                                        document: gql(query),
                                        variables: {
                                          'loginPassword':
                                              passwordController.text,
                                          'loginUsername':
                                              usernameController.text
                                        }),
                                    builder: (QueryResult result,
                                        {VoidCallback? refetch,
                                        FetchMore? fetchMore}) {
                                      if (result.hasException) {
                                        if (result.exception!.linkException !=
                                            null) {
                                          return ErrorPage(
                                            backwidget: LoginScreen(),
                                          );
                                        } else {
                                          return ErrorPage2(
                                            backwidget: LoginScreen(),
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

                                      token = result.data?['login']['token'];
                                      firstname =
                                          result.data?['login']['firstName'];
                                      middlename =
                                          result.data?['login']['middleName'];
                                      lastname =
                                          result.data?['login']['lastName'];
                                      phoneno =
                                          result.data?['login']['phone_no'];

                                      email = result.data?['login']['email'];
                                      //  image = result.data?['login']['image'];
                                      variables.setToken(token);
                                      print(token);
                                      usercontroller.setUserData(
                                        firstname,
                                        middlename,
                                        lastname,
                                        email,
                                        "",
                                        phoneno.toString(),
                                      );
                                      print("User Data" +
                                          firstname +
                                          middlename +
                                          lastname +
                                          email +
                                          phoneno.toString());
                                      return TempClass(token: token);
                                    }),
                              ),
                            );
                          });
                    } else {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            checkLogin();
                            return Container(
                              height: 150,
                              width: 150,
                            );
                          });
                    }
                  },
                  color: bgcolor,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "By continuing you agree to the terms and Conditions of Alga  ",
              style: TextStyle(color: bgcolor, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
