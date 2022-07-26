import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      sharedPrefs.saveToken(body['token']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else if (result2.statusCode == 200) {
      var body = jsonDecode(result2.body);
      sharedPrefs.saveToken(body['token']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminMainScreen()));
    } else if (result3.statusCode == 200) {
      var body = jsonDecode(result3.body);
      sharedPrefs.saveToken(body['token']);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: 120,),
                  Image.asset(
                    'assets/images/logo3.png',
                    width: 170,
                  ),
                  Text(
                    "متجراتي",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                      lable: "البريد الالكتروني",
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
                        return "الرجاء ادخال كلمة السر";
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: "كلمة السر",
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
                    width: double.infinity,
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
                        "تسجيل الدخول",
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
                        onPressed: () {},
                        child: Text("هل نسيت كلمة المرور؟"),
                      ),
                      SizedBox(width: 71),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text("جديد هنا؟ سجل الان!"),
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
