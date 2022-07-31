import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/editPassword/editPassword.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var formkey = GlobalKey<FormState>();
  String? value;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey2 = GlobalKey<FormState>();

  Future<UserModel> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/users/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    print(result.statusCode);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    nameController.text = userModel.name;
    emailController.text = userModel.email;

    return userModel;
  }

  Future<UserModel> editData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var body = jsonEncode(
        {'email': emailController.text, 'name': nameController.text});

    var result = await http.patch(Uri.parse(fetchData.baseURL + "/users/me"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        },
        body: body);

    print(result.statusCode);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    nameController.text = userModel.name;
    emailController.text = userModel.email;

    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: loadData(),
      builder: (context, snapshot) {
        var account = snapshot.data;
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.white,
              ),
            ),
          );
        } else {
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
                "حسابي".tr,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [],
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          //الصورة الشخصية
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  // backgroundImage: NetworkImage(
                                  //     'https://mystoreapii.herokuapp.com/users/${snapshot.data!.id}/avatar'),
                                  backgroundImage: account!.avatar == null
                                      ? (AssetImage(
                                          'assets/images/logo3.png',
                                        ) as ImageProvider)
                                      : MemoryImage(
                                          base64Decode(
                                              account.avatar.toString()),
                                        ),
                                ),
                                CircleAvatar(
                                  radius: 15.8,
                                  backgroundColor: Colors.blue,
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          //الاسم
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      height: 150.0,
                      padding: EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Form(
                            key: formkey2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "اسم المستخدم".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //الاسم
                                TextFormField(
                                  controller: nameController,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "الرجاء ادخال اسم المستخدم".tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //----------------------------------------------------------------------------------------------------
                                //البريد الالكتروني
                                Text(
                                  "البريد الالكتروني".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //البريد الالكتروني
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
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),

                                //تعديل
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors
                                        .blueAccent, // width: double.infinity,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      editData();
                                      if (formkey2.currentState!.validate()) {
                                        print(emailController.text);
                                        print(passwordController.text);
                                      }
                                    },
                                    child: Text(
                                      "تعديل".tr,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //تغيير كلمة السر
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color:
                                        Colors.grey, // width: double.infinity,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPasswordScreen()));
                                    },
                                    child: Text(
                                      "تغيير كلمة السر".tr,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      height: 550.0,
                      padding: EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        }
      },
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}

class _id {}
