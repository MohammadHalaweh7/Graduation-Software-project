import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/order/order_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/search/search_result_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:universal_io/io.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../aboutUs/about_us_screen.dart';
import '../account/account_screen.dart';
import '../home/main_screen.dart';
import '../my_orders/my_orders_all_screen.dart';
import '../notification/notification_screen.dart';

var Storeid;
var search = 'all';
var leastPrice = "L";
var highestPrice = "H";
String sortBY = 'تصاعدي';

class SearchScreen extends StatefulWidget {
  SearchScreen(id) {
    this.setStoreID(id);
  }

  setStoreID(ID) {
    Storeid = ID;
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var formkey = GlobalKey<FormState>();
  final items = ["تصاعدي".tr, "تنازلي".tr];
  String? value;

  var nameController = TextEditingController();
  var leastPriceController = TextEditingController();
  var highestPriceController = TextEditingController();

  //للبحث
  Icon customIcon = const Icon(
    Icons.search,
    size: 35,
  );
  Widget customSearchBar =  Text('البحث'.tr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  title: Text("الى المتاجر".tr),
                  leading: Icon(Icons.store, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
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
                            builder: (context) => AccountScreen()));
                  },
                ),
                ListTile(
                  title: Text("منتجات طلبتها".tr),
                  leading: Icon(Icons.add_chart, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrdersAllScreen()));
                  },
                ),
                ListTile(
                  title: Text("الاشعارات".tr),
                  leading: Icon(Icons.notification_important_outlined,
                      color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
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
                  leading: Icon(Icons.g_translate, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LanguageScreen()));
                  },
                ),
                ListTile(
                  title: Text("انشاء متجر".tr),
                  leading: Icon(Icons.person_add, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinAppScreen()));
                  },
                ),
                ListTile(
                  title: Text("عن محلات PS".tr),
                  leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUsScreen()));
                  },
                ),
                ListTile(
                  title: Text("تسجيل خروج".tr),
                  leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('token');
                    prefs.remove('type');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
       
      appBar: AppBar(
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 35,
            )),
        automaticallyImplyLeading: false,
        title: customSearchBar,
        // centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "اسم المنتج".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
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
                      decoration: InputDecoration(
                        labelText: "الاسم".tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //السعر
                    Text(
                      "السعر".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      height: 65,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "أقل سعر".tr,
                              style: TextStyle(fontSize: 17),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 70,
                              height: 40,
                              child: TextField(
                                controller: leastPriceController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      height: 65,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "أعلى سعر".tr,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 70,
                              height: 40,
                              child: TextField(
                                controller: highestPriceController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),




                    //رتب حسب
                    Text(
                      "رتب حسب السعر".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.arrow_downward_rounded),
                                    isExpanded: true,
                                    value: value,
                                    items: items.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() =>
                                        {this.value = value, sortBY = value!}),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //بحث
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blueAccent, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (leastPriceController.text == '') {
                            leastPrice = "L";
                          } else {
                            leastPrice = leastPriceController.text;
                          }
                          if (highestPriceController.text == '') {
                            highestPrice = "H";
                          } else {
                            highestPrice = highestPriceController.text;
                          }
                          if (nameController.text == '') {
                            search = "all";
                          } else {
                            search = nameController.text;
                          }

                          if ((leastPrice == "L" && highestPrice == "H") ||
                              (leastPrice != "L" && highestPrice != "H")) {
                            SearhResultScreen().setStoreID(Storeid);
                            SearhResultScreen().setname(search);
                            SearhResultScreen().setLeastPrice(leastPrice);
                            SearhResultScreen().setHighestPrice(highestPrice);
                            SearhResultScreen().setSortBy(sortBY);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearhResultScreen()));
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context),
                            );
                          }
                        },
                        child: Text(
                          "بحث".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //DropdownMenuItem Function---------------------------------------------------------------------------------
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
  //-----------------------------------------------------------------------------------------------------------

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
          Row(
            children: [
              Text("يجب اضافة اقل سعر واعلى سعر "),
              Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.blue,
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  //فنكشن مش مهم انساه
  void onNotification() {
    Navigator.pop(context);
  }
}
//----------------------------****************************
