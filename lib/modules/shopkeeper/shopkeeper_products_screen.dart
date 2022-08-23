import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_account_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_details_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_show_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_addNotification_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_allOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_deliveryOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_newOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_edit_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';

class ShopkeeperProductsScreen extends StatefulWidget {
  @override
  State<ShopkeeperProductsScreen> createState() =>
      _ShopkeeperProductsScreenState();
}

class _ShopkeeperProductsScreenState extends State<ShopkeeperProductsScreen> {
  fetchData fetch = fetchData();

  List<ProductModel> products = [];
  Widget getstoreproducts() {
    return FutureBuilder(
        future: fetch.allproducts(),
        builder: (contxt, snapchot) {
          products =
              snapchot.hasData ? snapchot.data as List<ProductModel> : [];

          return !snapchot.hasData
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return myproducts(
                      products[index].name,
                      products[index].description,
                      products[index].id,
                      products[index].price,
                      products[index].owner,
                      products[index].avatar,
                    );
                  });
        });
  }

  Widget myproducts(name, description, id, price, owner, avatar) {
    return //هاد بضم الكونتينر وكل اللي جواتو
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShopkeeperProductsEditScreen(
                          name, description, id, price, owner, avatar)));
            },
            child:
                //هاد الكونتينر بضم كلشي
                Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    //هاد للصورة
                    Container(
                      width: 135,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: avatar == null
                                ? (AssetImage(
                                    'assets/images/logo3.png',
                                  ) as ImageProvider)
                                : MemoryImage(
                                    base64Decode(avatar),
                                  ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 141,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'الأسم : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  'السعر : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  price.toString() + ' NIS',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'الوصف : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Expanded(
                                child: Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),

                            // Text('${article['publishedAt']}',style: TextStyle(color: Colors.grey,fontSize: 20),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          )
        ],
      ),
    );
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
          "المنتجات",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
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
           
      body: getstoreproducts(),
    );
  }

  //مش مهم
  void onNotification() {
    Navigator.pop(context);
  }
}



//--------------------------------------------------------------------------

