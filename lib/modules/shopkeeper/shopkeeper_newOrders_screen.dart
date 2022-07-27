import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/order/order_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_allOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_deliveryOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_newOrdersProducts_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';

class ShopkeeperNewOrdersScreen extends StatefulWidget {
  @override
  State<ShopkeeperNewOrdersScreen> createState() =>
      _ShopkeeperNewOrdersScreenState();
}

class _ShopkeeperNewOrdersScreenState extends State<ShopkeeperNewOrdersScreen> {
  fetchData fetch = fetchData();
  Widget getNewOrders() {
    return FutureBuilder(
        future: fetch.getNeworders(),
        builder: (contxt, snapchot) {
          var orders = snapchot.data as List<OrderModel>;
          return snapchot.data == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: orders == null ? 0 : orders.length,
                  itemBuilder: (context, index) {
                    return myNeworders(
                      orders[index].orderNumber,
                      orders[index].buyerName,
                      orders[index].buyerCity,
                      orders[index].buyerAddress,
                      orders[index].buyerPhone,
                      orders[index].buyerEmail,
                      orders[index].orderStatus,
                      orders[index].productName,
                      orders[index].price,
                      orders[index].id,
                      orders[index].avatar,
                    );
                  });
        });
  }

  Widget myNeworders(orderNumber, buyerName, buyerCity, buyerAddress,
      buyerPhone, buyerEmail, orderStatus, productName, price, id, avatar) {
    return //لكونتينر اللي بضم كلشي
        Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          //هون ديزاين الكونتينر
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  1,
                  1.0,
                ), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //رقم الطلب---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'رقم الطلب : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        orderNumber,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        width: 82,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.green, // width: double.infinity,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShopkeeperNewOrdersProductsScreen(
                                            orderNumber,
                                            buyerName,
                                            buyerCity,
                                            buyerAddress,
                                            buyerPhone,
                                            buyerEmail,
                                            orderStatus,
                                            productName,
                                            price,
                                            id,
                                            avatar)));
                          },
                          child: Text(
                            "التفاصيل",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //الخط الفاصل---------------------------------------------------------------------------------------------------------
                  Container(
                    width: 300,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // اسم المنتج---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      Text(
                        'اسم الشخص : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        buyerName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //المبلغ الاجمالي---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      Text(
                        'المدينة : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        buyerCity,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //العنوان---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      Text(
                        'العنوان : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        buyerAddress,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //هاتف---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      Text(
                        'الهاتف : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        buyerPhone,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //الايميل---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      Text(
                        'الايميل : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        buyerEmail,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //الحالة---------------------------------------------------------------------------------------------------------
                  Row(
                    children: [
                      Text(
                        'الحالة : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        orderStatus,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 5,
        ),
      ],
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
          "طلبات جديدة",
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
                          builder: (context) => ShopkeeperAccountScreen()));
                },
              ),
              ListTile(
                title: Text("متجري"),
                leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperProfileScreen()));
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
                          builder: (context) => ShopkeeperProductsScreen()));
                },
              ),
              ListTile(
                title: Text("اضافة منتج جديد"),
                leading:
                    Icon(Icons.add_shopping_cart, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),
              ListTile(
                title: Text("الطلبات الجديدة"),
                leading:
                    Icon(Icons.open_in_new_sharp, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperNewOrdersScreen()));
                },
              ),
              ListTile(
                title: Text("طلبات قيد التوصيل"),
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
                title: Text("جميع الطلبات"),
                leading:
                    Icon(Icons.clear_all_rounded, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperAllOrdersScreen()));
                },
              ),
              ListTile(
                title: Text("الاحصائيات"),
                leading: Icon(Icons.addchart_sharp, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperAllOrdersScreen()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
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
                leading: Icon(Icons.g_translate, color: Color(0xff758DFF)),
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
      body: getNewOrders(),
    );
  }

  void onNotification() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
  }
}

//--------------------------------------------------------------------------
