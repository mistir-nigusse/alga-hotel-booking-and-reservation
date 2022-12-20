import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/user_data.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/edit_profile_mutation.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_input_field.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_number_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/constants.dart';

class EditProfile extends StatefulWidget {
  final image;
  final fName;
  final mName;
  final lName;
  final int phoneNo;

  EditProfile(
      {Key? key,
      required this.image,
      required this.fName,
      required this.mName,
      required this.lName,
      required this.phoneNo})
      : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  VariablesController variables = Get.put(VariablesController());
  User user = Get.put(User());
  String? message;

  File? image;
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
            style: TextStyle(fontSize: 20, color: kPrimaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                  onPressed: () => addProfileImageFromCamera(),
                  icon: Icon(Icons.camera),
                  label: Text(
                    "take a photo",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 17,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                  onPressed: () => addProfileImageFromGallery(),
                  icon: Icon(Icons.image),
                  label: Text(
                    "open gallery",
                    style: TextStyle(color: kPrimaryColor, fontSize: 17),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HttpLink httpLink = HttpLink(
      'http://157.230.190.157/graphql',
      defaultHeaders: <String, String>{
        'Authorization': 'Bearer ${variables.getoken()}',
      },
    );
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ));
    Size size = MediaQuery.of(context).size;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height / 16,
            elevation: 0,
            title: Text("Edit Your Profile",
                style: TextStyle(
                    color: bgcolor, fontWeight: FontWeight.bold, fontSize: 18)),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: bgcolor),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: Mutation(
            options: MutationOptions(
              document: gql(EditProfileMutation().editprofilemutation),
              update: (GraphQLDataProxy cache, QueryResult? result) {
                return cache;
              },
              onCompleted: (dynamic resultData) {
                Get.back();
                print('finished gg');
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
                    backwidget: EditProfile(
                      image: widget.image,
                      fName: widget.fName,
                      lName: widget.lName,
                      mName: widget.mName,
                      phoneNo: widget.phoneNo,
                    ),
                  );
                } else {
                  return ErrorPage2(
                    backwidget: EditProfile(
                      image: widget.image,
                      fName: widget.fName,
                      lName: widget.lName,
                      mName: widget.mName,
                      phoneNo: widget.phoneNo,
                    ),
                    messagetext: message ?? "",
                  );
                }
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // change this to profile image

                          CircleAvatar(
                            backgroundImage: image == null
                                ? AssetImage("assets/images/profileIcon.png")
                                    as ImageProvider
                                : FileImage(File(image!.path)),
                            backgroundColor: Colors.white,
                            maxRadius: 50,
                          ),
                          SizedBox(width: size.width / 20),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: bgcolor,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) =>
                                        changeProfileBottomSheet()),
                                  );
                                },
                              ),
                              Text(
                                "change Profile",
                                style: TextStyle(
                                    color: bgcolorhex,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
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
                          hintText: widget.fName,
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
                          hintText: widget.mName,
                          onChanged: (value) {},
                          controller: middlenameController),
                      RoundedInputField(
                          inputformatter: [
                            new FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Last name';
                            }
                            return null;
                          },
                          hintText: widget.lName,
                          onChanged: (value) {},
                          controller: lastnameController),
                      RoundedNumberInputField(
                        validator: (value) {},
                        inputformatter: [
                          new FilteringTextInputFormatter.allow(
                              RegExp("[0-9]")),
                        ],
                        controller: phonenoController,
                        icon: Icons.phone,
                        hintText: widget.phoneNo.toString(),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: size.height * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedButton2(
                            text: "Save",
                            press: () {
                              setState(() {
                                user.editUserData(
                                    firstnameController.text,
                                    middlenameController.text,
                                    lastnameController.text,
                                    phonenoController.text,
                                    image!.path);

                                runMutation({
                                  'firstName': firstnameController.text == ""
                                      ? widget.fName
                                      : firstnameController.text,
                                  'middleName': middlenameController.text == ""
                                      ? widget.mName
                                      : middlenameController.text,
                                  'lastName': lastnameController.text == ""
                                      ? widget.lName
                                      : lastnameController.text,
                                  'phone_no': phonenoController.text == ""
                                      ? widget.phoneNo
                                      : int.parse(phonenoController.text),
                                  'image': image!.path == ""
                                      ? widget.image
                                      : FileImage(File(image!.path))
                                });
                              });
                            },
                          ),
                          RoundedButton2(
                            text: "Dismiss",
                            press: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
