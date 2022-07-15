import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_details_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';

class ShopKeeperMainScreen extends StatefulWidget {
  @override
  State<ShopKeeperMainScreen> createState() => _ShopKeeperMainScreenState();
}

class _ShopKeeperMainScreenState extends State<ShopKeeperMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: onNotification,
              icon: Icon(
                Icons.menu,
                color: Colors.blue,
                size: 35,
              )),
          title: Text(
            "الصفحة الرئيسية لصاحب المتجر",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                onNotification;
              },
              icon: Icon(
                Icons.add_alert_outlined,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ],
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
                  title: Text("الصفحة الرئيسية"),
                  leading: Icon(Icons.store, color: Color(0xff758DFF)),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("اضافة منتج"),
                  leading: Icon(Icons.production_quantity_limits,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Center(child: Text("الصفحة الرئيسية لصاحب المتجر")));
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}



//--------------------------------------------------------------------------

