import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/store/store_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:http/http.dart' as http;

class ShopkeeperProfileShowScreen extends StatefulWidget {
  @override
  State<ShopkeeperProfileShowScreen> createState() =>
      _ShopkeeperProfileShowScreenState();
}

class _ShopkeeperProfileShowScreenState
    extends State<ShopkeeperProfileShowScreen> {
  var defaultText = TextStyle(color: Colors.black);

  var linkText = TextStyle(color: Colors.black);

  Future<StoreModel> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    //print(token);

    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/store/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    //print(result.statusCode);

    StoreModel storeModel = StoreModel.fromJson(jsonDecode(result.body));

    return storeModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoreModel>(
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
              title: Icon(
                Icons.remove_red_eye_sharp,
                size: 30,
              ),

            ),
            drawer: Drawer(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, top: 30),
                      child: Image.asset(
                        'assets/images/logo3.png',
                        width: 150,
                      ),
                    ),
                    Text(
                      "متجراتي",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff758DFF)),
                    ),
                    SizedBox(
                      height: 20,
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
                        "الرئيسية",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("الى الرئيسية"),
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
                        "معلومات المستخدم",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("حسابي"),
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
                      title: Text("متجري"),
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
                      title: Text("منتجاتي"),
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
                      title: Text("اضافة منتج جديد"),
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
                      title: Text("حذف المتجر نهائيا"),
                      leading: Icon(Icons.highlight_remove_sharp,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProductScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("تسجيل خروج"),
                      leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('token');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
                      padding: const EdgeInsets.only(left: 220),
                      child: Text(
                        "التطبيق",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("اللغة"),
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
                      title: Text("عن متجراتي"),
                      leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("ضبط"),
                      leading: Icon(Icons.gamepad, color: Color(0xff758DFF)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("سياسة الخصوصية"),
                      leading: Icon(Icons.warning, color: Color(0xff758DFF)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics:BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    //الصورة
                    Container(
                      height: 340,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1.0), //(x,y)
                              blurRadius: 20.0,
                            ),
                          ],
                          color: Colors.white,
                          image: DecorationImage(
                              image: account!.avatar == null
                                  ? (NetworkImage(
                                      'https://www.nicepng.com/png/detail/254-2540580_we-create-a-customized-solution-to-meet-all.png',
                                    ) as ImageProvider)
                                  : MemoryImage(
                                      base64Decode(account.avatar.toString()),
                                    ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    //الاسم والوصف
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 140,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.name,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text(
                              account.description,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),

                    //هاتف
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "هاتف".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            account.phoneNumber,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    //زيارة موقعنا
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "زيارة موقعنا".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text(

                              account.detailedLocation,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    //فيسبوك
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "فيسبوك".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: account.facebook,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = account.facebook;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                        ],
                      ),
                    ),

                    //سناب شات
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.chat,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "سناب شات".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: account.snapchat,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = account.snapchat;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                        ],
                      ),
                    ),

                    //واتس أب
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "واتس أب".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            account.whatsapp,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    //انستغرام
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.wysiwyg,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "انستغرام".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: account.instagram,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = account.instagram;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                        ],
                      ),
                    ),

                    //عنوان المتجر
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.place_rounded,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "عنوان المتجر".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: account.locationOnMap,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = locationOnMap;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}