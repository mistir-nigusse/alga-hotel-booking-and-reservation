// ignore_for_file: unnecessary_statements

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/faded_page_route.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Signup/signup_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/otp/otp_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_number_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_password_field.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class SignupBody extends StatefulWidget {
  @override
  @override
  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  String? message;
  // File? userImage;
  var multipartFile;
  File? image;
  //AssetImage image1 = AssetImage("assets/images/profileIcon.png");
  Future addProfileImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
      // userImage = AssetImage("assets/images/profileIcon.png") as File;
    }
    final imageTemp = File(image.path);
    setState(() {
      this.image = imageTemp;
    });
  }

  Future addProfileImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
      // userImage = AssetImage("assets/images/profileIcon.png") as File;
    }
    final imageTemp = File(image.path);
    setState(() {
      this.image = imageTemp;
    });
  }

  Widget changeProfileBottomSheet() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 23, color: kPrimaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Center(
                child: TextButton.icon(
                    onPressed: () => addProfileImageFromCamera(),
                    icon: Icon(Icons.camera),
                    label: Text(
                      "take a photo",
                      style: TextStyle(color: kPrimaryColor, fontSize: 15),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Center(
                child: TextButton.icon(
                    onPressed: () => addProfileImageFromGallery(),
                    icon: Icon(Icons.image),
                    label: Text(
                      "open gallery",
                      style: TextStyle(color: kPrimaryColor, fontSize: 15),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  late TextEditingController firstnameController = TextEditingController(),
      lastnameController = TextEditingController(),
      middlenameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      phonenoController = TextEditingController(),
      confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
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

  bool checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      loginFormKey.currentState!.save();
      return true;
    }
  }

  String mutation = """
  mutation (\$firstName:String,\$lastName:String,\$middleName:String,\$phone_no:Int,\$email:String,\$password:String,\$nationality:String,\$image:Upload!){
  preRegister(userInfo:{firstName:\$firstName,lastName:\$lastName,middleName:\$middleName,phone_no:\$phone_no,email:\$email,password:\$password,nationality:\$nationality,image:\$image}) {
    message
  }
}
  """
      .replaceAll('\n', '');
  String nationality = 'Ethiopian';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Mutation(
          options: MutationOptions(
            document: gql(mutation),
            update: (GraphQLDataProxy cache, QueryResult? result) {
              if (loginFormKey.currentState!.validate() &&
                  !result!.hasException) {
                Navigator.push(
                    context,
                    FadePageRoute(
                        widget: OtpScreen(
                      firstname: firstnameController.text,
                      middlename: middlenameController.text,
                      lastname: lastnameController.text,
                      phoneno: phonenoController.text,
                      nationality: nationality,
                      email: emailController.text,
                    )));
                print('finished gg');
              } else {
                print("failed to register");
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
                  backwidget: SignUpScreen(),
                );
              } else {
                return ErrorPage2(
                  backwidget: SignUpScreen(),
                  messagetext: message ?? "",
                );
              }
            }
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: size.height * 0.03),
                      Image.asset(
                        "assets/icons/logo.png",
                        height: size.height * 0.3,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: bgcolor2,
                        backgroundImage: image == null
                            ? AssetImage("assets/images/profileIcon.png")
                                as ImageProvider
                            : FileImage(File(image!.path)),
                      ),
// modalchangeProfileBottomSheet pop up when camera icon is tapped
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) =>
                                  changeProfileBottomSheet()),
                            );
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 22,
                            color: bgcolor,
                          )),
                      RoundedInputField(
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter First name';
                            }
                            return null;
                          },
                          hintText: "Your First Name *",
                          onChanged: (value) {},
                          controller: firstnameController),
                      RoundedInputField(
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Middle name';
                            }
                            return null;
                          },
                          hintText: "Your Middle Name *",
                          onChanged: (value) {},
                          controller: middlenameController),
                      RoundedInputField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Last name';
                          }
                          return null;
                        },
                        inputformatter: [
                          new FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z]")),
                        ],
                        hintText: "Your Last Name *",
                        onChanged: (value) {},
                        controller: lastnameController,
                      ),
                      RoundedInputField(
                          icon: Icons.mail,
                          hintText: "Your Email *",
                          onChanged: (value) {},
                          controller: emailController,
                          validator: (value) {
                            return validateEmail(value!);
                          }),
                      RoundedNumberInputField(
                        validator: (value) {
                          return validatePhoneNo(value!);
                        },
                        inputformatter: [
                          new FilteringTextInputFormatter.allow(
                              RegExp("[0-9]")),
                        ],
                        controller: phonenoController,
                        icon: Icons.phone,
                        hintText: "Your Phone.No *",
                        onChanged: (value) {},
                      ),
                      RoundedPasswordField(
                        controller: passwordController,
                        validator: (String? value) {
                          return validatePassword(value!);
                        },
                        hinttext: 'Password *',
                      ),
                      RoundedPasswordField(
                        controller: confirmPasswordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Confirm Password can't empty";
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        hinttext: 'Confirm password *',
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
                              text: "Register",
                              color: bgcolor,
                              press: () {
                                if (image == null) {
                                  multipartFile = AssetImage(
                                      "assets/images/profileIcon.png");
                                } else {
                                  multipartFile = http.MultipartFile.fromBytes(
                                      'photo',
                                      File(image!.path).readAsBytesSync(),
                                      filename: image!.path,
                                      contentType: MediaType("image", "jpg"));
                                }

                                print(" register button clicked");
                                print('$emailController.text');
                                bool x = checkLogin();
                                if (x) {
                                  runMutation({
                                    'email': emailController.text,
                                    'firstName': firstnameController.text,
                                    'middleName': middlenameController.text,
                                    'lastName': lastnameController.text,
                                    'password': passwordController.text,
                                    'nationality': nationality,
                                    'phone_no':
                                        double.parse(phonenoController.text),
                                    'image': multipartFile
                                  });
                                  print(multipartFile);

                                  Navigator.push(
                                      context,
                                      FadePageRoute(
                                          widget: OtpScreen(
                                        firstname: firstnameController.text,
                                        middlename: middlenameController.text,
                                        lastname: lastnameController.text,
                                        phoneno: phonenoController.text,
                                        nationality: nationality,
                                        email: emailController.text,
                                        //      image: multipartFile,
                                      )));
                                } else {
                                  Get.snackbar("Error",
                                      "One or More fields have wrong input please check yor input.",
                                      snackPosition: SnackPosition.TOP,
                                      colorText: bgcolor,
                                      backgroundColor: Colors.white,
                                      borderColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                      animationDuration: Duration(seconds: 2),
                                      borderRadius: 15,
                                      borderWidth: 2.5);
                                  // Navigator.push(
                                  //     context,
                                  //     FadePageRoute(
                                  //         widget: OtpScreen(
                                  //       firstname: firstnameController.text,
                                  //       middlename: middlenameController.text,
                                  //       lastname: lastnameController.text,
                                  //       phoneno: phonenoController.text,
                                  //       nationality: nationality,
                                  //       email: emailController.text,
                                  //     )));

                                }
                                ;
                              }),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
