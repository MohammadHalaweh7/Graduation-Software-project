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
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_deliveryOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_newOrders_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_allOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_deliveryOrders_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_newOrdersProducts_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';

var orderNumber;
var buyerName;
var buyerCity;
var buyerAddress;
var buyerPhone;
var buyerEmail;
var orderStatus;
var productName;
var price;
var id;
var avatar;

class ShopkeeperDeliveryOrdersProductsScreen extends StatefulWidget {
  ShopkeeperDeliveryOrdersProductsScreen(
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
      avatar) {
    this.setData(orderNumber, buyerName, buyerCity, buyerAddress, buyerPhone,
        buyerEmail, orderStatus, productName, price, id, avatar);
  }
  setData(OrderNumber, BuyerName, BuyerCity, BuyerAddress, BuyerPhone,
      BuyerEmail, OrderStatus, ProductName, Price, Id, Avatar) {
    orderNumber = OrderNumber;
    buyerName = BuyerName;
    buyerCity = BuyerCity;
    buyerAddress = BuyerAddress;
    buyerPhone = BuyerPhone;
    buyerEmail = BuyerEmail;
    orderStatus = OrderStatus;
    productName = ProductName;
    price = Price;
    id = Id;
    avatar = Avatar;
  }

  @override
  State<ShopkeeperDeliveryOrdersProductsScreen> createState() =>
      _ShopkeeperDeliveryOrdersProductsScreenState();
}

class _ShopkeeperDeliveryOrdersProductsScreenState
    extends State<ShopkeeperDeliveryOrdersProductsScreen> {
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
          "تفاصيل الطلب",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [

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
      body: Container(
//هون ديزاين الكونتينر
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
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
//صورة المتجر---------------------------------------------------------------------------------------------------------
                Row(
                  children: [
                    Text(
                      'صورة المنتج : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[500]),
                    ),
                    Spacer(),
                    Container(
                      width: 90,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
// اسم المنتج---------------------------------------------------------------------------------------------------------
                Row(
                  children: [
                    Text(
                      'اسم المنتج : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[500]),
                    ),
                    Spacer(),
                    Text(
                      productName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
//سعر المنتج---------------------------------------------------------------------------------------------------------
                Row(
                  children: [
                    Text(
                      'سعر المنتج : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[500]),
                    ),
                    Spacer(),
                    Text(
                      price + ' NIS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // الحجم---------------------------------------------------------------------------------------------------------
                Row(
                  children: [
                    Text(
                      'الحجم : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                    Spacer(),
                    Text(
                      "....",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }

  void onNotification() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShopkeeperDeliveryOrdersScreen()));
  }
}



//--------------------------------------------------------------------------
