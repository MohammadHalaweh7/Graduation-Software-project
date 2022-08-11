import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_account_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_addNotification_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_add_remove_poster_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_all_poster_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_profile_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_details_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_add_poster_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
import 'package:http/http.dart' as http;

class AdminMainScreen extends StatefulWidget {
  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  var nameController = TextEditingController();
  Future<UserModel> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/admin/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    print(result.statusCode);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    nameController.text = userModel.name;

    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;

    var size = MediaQuery.of(context).size;
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
            endDrawer: Drawer(
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
                      title: Text("عن متجراتي".tr),
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
            body: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.9,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: Image.network(
                            "https://www.pngkey.com/png/full/336-3369360_website-banner-background-png-header-png.png")
                        .image,
                  )),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 65,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminAccountScreen()));
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      // backgroundImage: NetworkImage(
                                      //     'https://j-rak.org.sa/wp-content/uploads/2021/02/5f406ab25e8942cbe0da6485afd26b71.jpg'),
                                      backgroundImage: account!.avatar == null
                                          ? (NetworkImage(
                                              'https://j-rak.org.sa/wp-content/uploads/2021/02/5f406ab25e8942cbe0da6485afd26b71.jpg',
                                            ) as ImageProvider)
                                          : MemoryImage(
                                              base64Decode(
                                                  account.avatar.toString()),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        account.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 17.5),
                                      ),
                                      Text(
                                        'Admin',
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 2,
                                            fontSize: 11),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 2,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Builder(
                                    builder: (context) => IconButton(
                                      icon: new Icon(
                                        Icons.menu,
                                        size: 38,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          Scaffold.of(context).openEndDrawer(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Spacer(),
                            Container(
                              width: screenHight * 0.6,
                              height: 512,
                              child: GridView.count(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(10),
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 1 / 1.9,
                                crossAxisCount: 3,
                                // shrinkWrap: true,
                                primary: false,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminAccountScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/adminIMG.jpg',
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'حسابي'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminProfileScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://library.kissclipart.com/20180914/bhw/kissclipart-7-clipart-ipho-1ff0ee7a9f7b557f.png",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'من نحن !'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminShopsScreen()));
                                    },
                                    child: Container(
                                      // width:screenWidth*0.2 ,
                                      // height: screenHight*0.1,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://hebergement-site-web.ma/hebergement-site-prestashop/wp-content/uploads/sites/24/2021/04/Selection_147.png",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'جميع المتاجر'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              'https://thumbs.dreamstime.com/b/document-icons-add-remove-buttons-symbol-set-royalty-free-vector-illustration-95581404.jpg',
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'الطلبات'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNotificationScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://static.vecteezy.com/system/resources/previews/002/130/449/original/new-message-notification-icon-email-alert-chat-notice-illustration-with-smartphone-screen-isolated-mobile-reminder-web-concept-envelopes-number-one-online-message-push-notification-logo-vector.jpg",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'التنبيهات'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminAddPosterScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://www.owesomesoft.com/img/mobilemarket.png",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'انشاء اعلان'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminAddRemovePosterScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://icon-library.com/images/37-512.png",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'الاعلانات'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminAllPosterScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://howto.bucksense.com/wp-content/uploads/2016/09/chatlist.png",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'اعلاناتي'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                 
                                 
                                 
                                 
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.remove('token');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Container(
                                      width: screenWidth / 5,
                                      height: screenWidth / 9,
                                      child: Card(
                                        elevation: 15,
                                        shadowColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                              "https://us.123rf.com/450wm/faysalfarhan/faysalfarhan1710/faysalfarhan171013860/88895640-logout-icon-isolated-on-special-red-square-button-abstract-illustration.jpg?ver=6",
                                              height: 105,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'خروج'.tr,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}



//--------------------------------------------------------------------------

