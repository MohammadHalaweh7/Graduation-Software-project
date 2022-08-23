import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_account_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_addNotification_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_allOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_deliveryOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_newOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:http/http.dart' as http;

class ShopkeeperEditPasswordScreen extends StatefulWidget {
  @override
  State<ShopkeeperEditPasswordScreen> createState() =>
      _ShopkeeperEditPasswordScreenState();
}

class _ShopkeeperEditPasswordScreenState
    extends State<ShopkeeperEditPasswordScreen> {
  var formkey = GlobalKey<FormState>();
  String? value;
  var passwordController = TextEditingController();
  var passwordVerifiyController = TextEditingController();

  Future<void> editData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    // print(token);

    if (passwordController.text == passwordVerifiyController.text) {
      var body = jsonEncode({'password': passwordController.text});

      var result =
          await http.patch(Uri.parse(fetchData.baseURL + "/store/editInfo"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ' + token.toString()
              },
              body: body);

      print(result.statusCode);
      if (result.statusCode == 200) {
        passwordController.text = '';
        passwordVerifiyController.text = '';
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      }
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
          "تغيير كلمة السر".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
            drawer: Drawer(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 30),
                  child: Image.asset(
                    'assets/images/logo3.png',
                    width: 180,
                  ),
                ),
                    Container(
                      width: 300,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 220),
                      child: Text(
                        "الرئيسية".tr,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("الى الرئيسية".tr),
                      leading: Icon(Icons.store, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopKeeperMainScreen()));
                      },
                    ),
                    Container(
                      width: 300,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 147),
                      child: Text(
                        "معلومات المستخدم".tr,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("حسابي".tr),
                      leading: Icon(Icons.person, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperAccountScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("متجري".tr),
                      leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperProfileScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("منتجاتي".tr),
                      leading: Icon(Icons.production_quantity_limits,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperProductsScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("اضافة منتج جديد".tr),
                      leading: Icon(Icons.add_shopping_cart,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProductScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("الطلبات الجديدة".tr),
                      leading: Icon(Icons.open_in_new_sharp,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperNewOrdersScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("طلبات قيد التوصيل".tr),
                      leading: Icon(Icons.delivery_dining_rounded,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperDeliveryOrdersScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("جميع الطلبات".tr),
                      leading: Icon(Icons.clear_all_rounded,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperAllOrdersScreen()));
                      },
                    ),

                    ListTile(
                      title: Text("ارسال الاشعارات".tr),
                      leading: Icon(Icons.add_alert, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShopkeeperAddNotificationScreen()));
                      },
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      width: 300,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Text(
                        "التطبيق".tr,
                        
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("اللغة".tr),
                      leading:
                          Icon(Icons.g_translate, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("عن محلات PS".tr),
                      leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("تسجيل خروج".tr),
                      leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('token');
                        prefs.remove('type');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
           
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //كلمة المرور
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "كلمة المرور".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //كلمة المرور
                          TextFormField(
                            controller: passwordController,
                            onFieldSubmitted: (String value) {
                              print(value);
                            },
                            onChanged: (String value) {
                              print(value);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "الرجاء ادخال كلمة المرور".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'كلمة السر'
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //----------------------------------------------------------------------------------------------------
                          //تاكيد كلمة المرور
                          Text(
                            "تاكيد كلمة المرور".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // تاكيد كلمة المرور
                          TextFormField(
                            controller: passwordVerifiyController,
                            onFieldSubmitted: (String value) {
                              print(value);
                            },
                            onChanged: (String value) {
                              print(value);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "الرجاء ادخال كلمة المرور".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),

                          //تعديل
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color:
                                  Colors.blueAccent, // width: double.infinity,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                editData();
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
                        ],
                      ),
                    ),
                  ],
                ),

                height: 500.0,
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

  //Pub up Function--------------------------------------------------------------------------------------------
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
          Text("تم تغيير كلمة السر بنجاح".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopkeeperAccountScreen()));
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }

  //------------------------------------------------------------------------------------------------------------
  void onNotification() {
    Navigator.pop(context);
  }
}
