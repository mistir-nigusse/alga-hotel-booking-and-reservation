import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final radiusController = TextEditingController();

  VariablesController variables = Get.put(VariablesController());
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
          "Settings",
          style: TextStyle(color: bgcolor),
        ),
        leading: Builder(
            builder: (con) => IconButton(
                  icon: Icon(CupertinoIcons.list_dash, color: bgcolor),
                  onPressed: () => Scaffold.of(con).openDrawer(),
                )),
      ),
      drawer: Mydrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: bgcolor, style: BorderStyle.solid, width: 2.5),
                      color: Color(0xFFF6F7FF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Set Hotel Search Radius Value'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: variables.getRadius().toString(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        keyboardType: TextInputType.phone,
                        controller: radiusController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          new FilteringTextInputFormatter.allow(
                              RegExp("[0-9]")),
                        ],
                      ),
                    ],
                  ),
                ),
                RoundedButton5(
                    text: "Save",
                    press: () {
                      variables.setRadius(radiusController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => super.widget));
                    },
                    color: bgcolor,
                    size: MediaQuery.of(context).size.width * 0.4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
