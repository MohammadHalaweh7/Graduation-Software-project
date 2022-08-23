import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/API/fetchData.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../login/login_screen.dart';
import 'package:http/http.dart' as http;

class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var emailController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  Future<void> ForgetPassword(BuildContext context) async {
    var body = jsonEncode({
      'email': emailController.text,
    });

    //print(body);
    var result = await http.post(
        Uri.parse(fetchData.baseURL + "/forgetPassword"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);

    if (result.statusCode == 200) {
      var body = jsonDecode(result.body);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 35,
            )),
        title: Text(
          "هل نسيت كلمة المرور !".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Image.asset(
                      'assets/images/logo3.png',
                      width: 220,
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء ادخال البريد الالكتروني".tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // hintText: "البريد الالكتروني",
                      labelText: "البريد الالكتروني".tr,
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.blueAccent, // width: double.infinity,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        ForgetPassword(context);
                      },
                      child: Text(
                        "ارسال".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "عضو بالفعل؟ سجل الدخول!".tr,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF391248)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              radius: 17,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.check,
                color: Colors.white,
              )),
          SizedBox(
            height: 10,
          ),
          Text("ستصلك رسالة على بريدك الالكتروني تحتوي كلمة المرور الجديدة")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}
