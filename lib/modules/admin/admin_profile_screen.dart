import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/aboutus/aboutus_model.dart';
import 'package:udemy_flutter/modules/admin/admin_profile_edit_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../layout/shop_layout/shop_layout.dart';
import '../../src/my_app.dart';
import 'package:http/http.dart' as http;

import 'adminMain_screen.dart';
import 'admin_account_screen.dart';
import 'admin_addNotification_screen.dart';
import 'admin_screen.dart';
import 'admin_shops_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  var defaultText = TextStyle(color: Colors.black);

  var linkText = TextStyle(color: Colors.black);
  var aboutUscontroller = TextEditingController();
  var aboutStorecontroller = TextEditingController();
  var specialcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var facebookcontroller = TextEditingController();
  var snapChatcontroller = TextEditingController();
  var instagramcontroller = TextEditingController();
  var whatsappcontroller = TextEditingController();

  Future<AboutUsModel> loadData() async {
    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/aboutUs/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(result.statusCode);
    //print(result.body);

    AboutUsModel aboutusModel = AboutUsModel.fromJson(jsonDecode(result.body));

    // nameController.text = userModel.name;
    // emailController.text = userModel.email;
    return aboutusModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AboutUsModel>(
      future: loadData(),
      builder: (context, snapshot) {
        var aboutUs = snapshot.data;
        // print(snapshot.data);
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
                                builder: (context) => AdminMainScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("الى المتاجر".tr),
                      leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminShopsScreen()));
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
                                builder: (context) => AdminAccountScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("طلبات المتاجر الجديدة".tr),
                      leading: Icon(Icons.remove_from_queue_outlined,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("ارسال اشعارات".tr),
                      leading: Icon(Icons.notification_add,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNotificationScreen()));
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
                      onTap: () {
                            Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminProfileScreen()));
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
                "من نحن!".tr,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                              image: aboutUs!.avatar == null
                                  ? AssetImage(
                                      'assets/images/logo3.png',
                                    ) as ImageProvider
                                  : MemoryImage(
                                      base64Decode(aboutUs.avatar.toString()),
                                    ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.grey[300], // width: double.infinity,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminProfileEditScreen()));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "تعديل المعلومات".tr,
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.edit_sharp,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    //الشرح
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
                      height: 670,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //من نحن
                          Center(
                            child: Text(
                              'من نحن !'.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //الشرح
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text(
                              aboutUs.aboutUsDescription.tr,
                              maxLines: 50,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //عن متجراتي
                          Center(
                            child: Text(
                             'عن محلات PS'.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //الشرح
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text(
                              aboutUs.aboutStoreDescription.tr,
                              maxLines: 50,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //من نحن
                          Center(
                            child: Text(
                              'ما يميزنا !'.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //  الشرح
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text(
                              aboutUs.makeUsSpecial.tr,
                              maxLines: 50,
                              overflow: TextOverflow.ellipsis,
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
                    SizedBox(
                      height: 20,
                    ),

                    //تواصل معنا
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "تواصل معنا".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    //هاتف
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
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
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
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
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            aboutUs.phoneNumber,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    //فيسبوك
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
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
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
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
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: linkText,
                                      text: aboutUs.facebook,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url = facebook;
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw " cannot load url";
                                          }
                                        }),
                                ])),
                          ),
                        ],
                      ),
                    ),

                    //سناب شات
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
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
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
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
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 182,
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: linkText,
                                      text: aboutUs.snapChat,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url = snapchat;
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw " cannot load url";
                                          }
                                        }),
                                ])),
                          ),
                        ],
                      ),
                    ),

                    //انستغرام
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
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
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
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
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: linkText,
                                      text: aboutUs.instagram,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url = instagram;
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw " cannot load url";
                                          }
                                        }),
                                ])),
                          ),
                        ],
                      ),
                    ),

                    //واتس أب
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
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
                      height: 67,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
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
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            aboutUs.whatsapp,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
