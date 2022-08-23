import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/API/sharedPrefs.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:http/http.dart' as http;

import '../home/home_screen.dart';
//Mohammad
//Reusable Components

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  //...........

//............
  var formkey = GlobalKey<FormState>();

  bool isPassword = true;

  //Haytham---------------------------------------------------------------------
  // ignore: non_constant_identifier_names
  Future<void> Login() async {
    print(emailController.text);
    print(passwordController.text);

    var body = jsonEncode(
        {'email': emailController.text, 'password': passwordController.text});

    print(body);

    var result = await http.post(Uri.parse(fetchData.baseURL + "/users/login"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);

    var result2 = await http.post(Uri.parse(fetchData.baseURL + "/admin/login"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);

    var result3 = await http.post(Uri.parse(fetchData.baseURL + "/store/login"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);

    if (result.statusCode == 200) {
      var body = jsonDecode(result.body);
      sharedPrefs.saveToken(body['token'], 'USER');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else if (result2.statusCode == 200) {
      var body = jsonDecode(result2.body);
      sharedPrefs.saveToken(body['token'], 'ADMIN');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminMainScreen()));
    } else if (result3.statusCode == 200) {
      var body = jsonDecode(result3.body);
      sharedPrefs.saveToken(body['token'], 'STORE');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    'assets/images/logo3.png',
                    width: 210,
                  ),
                  Text(
                    "أهلا بك في محلات PS",
                    style: TextStyle(
                      fontFamily:'myFont',
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF391248)),
                  ),
                    SizedBox(
                    height: 0,
                  ),
                                   Text(
                    "محلات فلسطين في مكان واحد",
                    style: TextStyle(
                      fontFamily:'myFont',
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF999999)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                      lable: "البريد الالكتروني".tr,
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      controller: emailController),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الرجاء ادخال كلمة السر".tr;
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: "كلمة السر".tr,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: isPassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  //     color: Colors.blueAccent, // width: double.infinity,
                  //   ),
                  //   child: IconButton(
                  //     onPressed: () {
                  //       //TODO
                  //       Login();
                  //       if (formkey.currentState!.validate()) {
                  //         print(emailController.text);
                  //         print(passwordController.text);
                  //       }
                  //     },
                  //     icon: isPassword
                  //         ? Icon(Icons.visibility)
                  //         : Icon(Icons.visibility_off),
                  //     // border: OutlineInputBorder(),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.blueAccent, // width: double.infinity,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        //............
                        Login();
                        if (formkey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      child: Text(
                        "تسجيل الدخول".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordScreen()));
                        },
                        child: Text(
                          "هل نسيت كلمة المرور؟".tr,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF391248)),
                        ),
                      ),
                      // SizedBox(width: 71),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "جديد هنا؟ سجل الان!".tr,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF391248)),
                        ),
                      )
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
}

//Pub up Function(2)--------------------------------------------------------------------------------------------
Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
            radius: 17,
            backgroundColor: Colors.red,
            child: Icon(
              Icons.error,
              color: Colors.white,
            )),
        SizedBox(
          height: 10,
        ),
        Text("الايميل او كلمة السر غير صحيحة !!!")
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Colors.blue,
        child: Text('موافق'.tr),
      ),
    ],
  );
}
