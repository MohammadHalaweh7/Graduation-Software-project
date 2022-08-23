import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../aboutUs/about_us_screen.dart';
import '../login/login_screen.dart';
import '../my_orders/my_orders_all_screen.dart';
import '../notification/notification_screen.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // final items = ['Arabic', 'English'];
  // String? value;

  String _selectedLang = 'ar';
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
            "حدد اللغة".tr,
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
       
        body: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(5)),
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text('Arabic'),
                    value: 'ar',
                  ),
                ],
                value: _selectedLang,
                onChanged: (value) {
                  setState(() {
                    _selectedLang = value as String;
                  });
                  Get.updateLocale(Locale(_selectedLang));
                },
              ),
            ),
          ),
        )

        // Padding(
        //   padding:const EdgeInsets.all(20),
        //   child: Container(
        //     child: SingleChildScrollView(
        //       scrollDirection: Axis.vertical,
        //       child:
        //       Column(
        //         // crossAxisAlignment: CrossAxisAlignment.center,
        //
        //         children:
        //         [
        //
        //           SizedBox(
        //             height: 20,
        //           ),
        //
        //
        //
        //           Container(
        //             margin: EdgeInsets.all(16),
        //             padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
        //             decoration: BoxDecoration(
        //               border: Border.all(color: Colors.grey,width: 2),
        //               borderRadius: BorderRadius.circular(10)
        //             ),
        //             child: DropdownButtonHideUnderline(
        //               child: DropdownButton<String>
        //                 (
        //                 icon: Icon(Icons.language),
        //                 isExpanded: true,
        //                 value: value,
        //                 items: items.map(buildMenuItem).toList(),
        //                   onChanged:(value) => setState(() {
        //                     this.value=value;
        //                   }),
        //
        //               ),
        //             ),
        //           ),
        //
        //
        //           SizedBox(
        //             height: 20,
        //           ),
        //
        //
        //         ],),
        //     ),
        //   ),
        // ),

        );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );

  void onNotification() {
    Navigator.pop(context);
  }
}
