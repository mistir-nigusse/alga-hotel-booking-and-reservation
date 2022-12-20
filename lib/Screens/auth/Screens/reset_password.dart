import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/no_internet.dart';
import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController codeController = TextEditingController();
  var email = '';
  var password = '';
  var code = '';
  String? message;
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }
    return null;
  }

  String? validatecode(String value) {
    if (value.length > 4) {
      return "code must be 4 digit";
    }
    return null;
  }

  String mutation1 = """
  mutation(\$preUserChangePasswordEmail: String){
  preUserChangePassword(email: \$preUserChangePasswordEmail) {
    message
  }
}
  """;
  String mutation2 = """
  mutation(\$userChangePasswordCode: String, \$userChangePasswordPassword: String){
 userChangePassword(code: \$userChangePasswordCode,password: \$userChangePasswordPassword) {
   message
 }
}
  """;
  bool codeSent = false;
  VariablesController variables = Get.put(VariablesController());
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
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
    return GraphQLProvider(
        client: client,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height / 15,
              elevation: 0.0,
              backgroundColor: Color(0xFFF6F7FF),
              leading: IconButton(
                icon: Icon(Icons.chevron_left, color: bgcolor, size: 35),
                onPressed: () {
                  Get.back();
                },
              ),
              automaticallyImplyLeading: false,
              title: Text(
                "Reset Password",
                style: TextStyle(color: bgcolor),
              ),
            ),
            body: OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;

                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      child,
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: connected
                              ? Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Mutation(
                                          options: MutationOptions(
                                            document: gql(mutation1),
                                            update: (GraphQLDataProxy cache,
                                                QueryResult? result) {
                                              return cache;
                                            },
                                            onCompleted: (dynamic resultData) {
                                              print('finished g1');
                                              codeSent = true;
                                            },
                                            onError: (error) {
                                              //print(error);
                                              setState(() {
                                                message = error!
                                                    .graphqlErrors[0].message;
                                              });
                                            },
                                          ),
                                          builder: (
                                            RunMutation runMutation,
                                            QueryResult? result,
                                          ) {
                                            if (result!.isLoading) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: bgcolor));
                                            }
                                            if (result.hasException) {
                                              if (result.exception!
                                                      .linkException !=
                                                  null) {
                                                return ErrorPage(
                                                  backwidget: ResetPassword(),
                                                );
                                              } else {
                                                return ErrorPage2(
                                                  backwidget: ResetPassword(),
                                                  messagetext: message ?? "",
                                                );
                                              }
                                            }
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20),
                                                    child: TextFormField(
                                                      cursorColor: bgcolor,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: bgcolor
                                                                  .withOpacity(
                                                                      0.5)),
                                                        ),
                                                        labelText: "Email",
                                                        labelStyle: TextStyle(
                                                            color: myFocusNode
                                                                    .hasFocus
                                                                ? bgcolor
                                                                    .withOpacity(
                                                                        0.5)
                                                                : bgcolor),
                                                        helperText:
                                                            'Enter Your Email Here',
                                                        focusColor: bgcolor,
                                                        hoverColor: bgcolor,
                                                        fillColor: bgcolor,
                                                        prefixIcon: Icon(
                                                          Icons.email,
                                                          color: bgcolor,
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      controller:
                                                          emailController,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      onSaved: (value) {
                                                        email = value!;
                                                      },
                                                      validator: (value) {
                                                        return validateEmail(
                                                            value!);
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 20),
                                                    child: RoundedButton5(
                                                        text: "Submit Email",
                                                        press: () {
                                                          runMutation({
                                                            'preUserChangePasswordEmail':
                                                                emailController
                                                                    .text,
                                                          });
                                                        },
                                                        color: bgcolor,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        if (codeSent = true)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Mutation(
                                                options: MutationOptions(
                                                  document: gql(mutation2),
                                                  update:
                                                      (GraphQLDataProxy cache,
                                                          QueryResult? result) {
                                                    return cache;
                                                  },
                                                  onCompleted:
                                                      (dynamic resultData) {
                                                    print('finished g2');
                                                  },
                                                  onError: (error) {
                                                    //print(error);
                                                    setState(() {
                                                      message = error!
                                                          .graphqlErrors[0]
                                                          .message;
                                                    });
                                                  },
                                                ),
                                                builder: (
                                                  RunMutation runMutation,
                                                  QueryResult? result,
                                                ) {
                                                  if (result!.isLoading) {
                                                    return Center(
                                                        child: Center(
                                                            child: CircularProgressIndicator(
                                                                color:
                                                                    bgcolor)));
                                                  }
                                                  if (result.hasException) {
                                                    if (result.exception!
                                                            .linkException !=
                                                        null) {
                                                      return Expanded(
                                                        child: ErrorPage(
                                                          backwidget:
                                                              ResetPassword(),
                                                        ),
                                                      );
                                                    } else {
                                                      return Expanded(
                                                        child: ErrorPage2(
                                                          backwidget:
                                                              ResetPassword(),
                                                          messagetext:
                                                              message ?? "",
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  return Column(
                                                    children: [
                                                      TextFormField(
                                                        cursorColor: bgcolor,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: bgcolor
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                          focusColor: bgcolor,
                                                          hoverColor: bgcolor,
                                                          fillColor: bgcolor,
                                                          labelText: "Code",
                                                          labelStyle: TextStyle(
                                                              color: myFocusNode
                                                                      .hasFocus
                                                                  ? bgcolor
                                                                      .withOpacity(
                                                                          0.5)
                                                                  : bgcolor),
                                                          helperText:
                                                              'Enter the code here',
                                                          prefixIcon: Icon(
                                                            Icons.vpn_key,
                                                            color: bgcolor,
                                                          ),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        obscureText: true,
                                                        maxLength: 4,
                                                        controller:
                                                            codeController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        onSaved: (value) {
                                                          code = value!;
                                                        },
                                                        validator: (value) {
                                                          return validatecode(
                                                              value!);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        cursorColor: bgcolor,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          focusColor: bgcolor,
                                                          hoverColor: bgcolor,
                                                          fillColor: bgcolor,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: bgcolor
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                          labelText: "Password",
                                                          labelStyle: TextStyle(
                                                              color: myFocusNode
                                                                      .hasFocus
                                                                  ? bgcolor
                                                                      .withOpacity(
                                                                          0.5)
                                                                  : bgcolor),
                                                          helperText:
                                                              'Enter the new password',
                                                          prefixIcon: Icon(
                                                            Icons.lock,
                                                            color: bgcolor,
                                                          ),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        obscureText: true,
                                                        controller:
                                                            passwordController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        onSaved: (value) {
                                                          password = value!;
                                                        },
                                                        validator: (value) {
                                                          return validatePassword(
                                                              value!);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      RoundedButton5(
                                                          text:
                                                              'Change Password',
                                                          press: () {
                                                            runMutation({
                                                              'userChangePasswordCode':
                                                                  codeController
                                                                      .text,
                                                              'userChangePasswordPassword':
                                                                  passwordController
                                                                      .text,
                                                            });
                                                          },
                                                          color: bgcolor,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2),
                                                    ],
                                                  );
                                                }),
                                          )
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
                ))));
  }
}
