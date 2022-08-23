import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/order/order_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_addNotification_screen.dart';
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
import 'package:http/http.dart' as http;

var id;
var size;
var storeName;
var total;

class ShopkeeperNewOrdersProductsScreen extends StatefulWidget {
  setID(ID) {
    id = ID;
  }

  setSize(S) {
    size = S;
  }

  setStoreName(Storename) {
    storeName = Storename;
  }

  setTotal(T) {
    total = T;
  }

  @override
  State<ShopkeeperNewOrdersProductsScreen> createState() =>
      _ShopkeeperNewOrdersProductsScreenState();
}

class _ShopkeeperNewOrdersProductsScreenState
    extends State<ShopkeeperNewOrdersProductsScreen> {
  var totalController = TextEditingController();

  Future<OrderModel> changeOrderStatus(id) async {
    var ID = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.patch(
      Uri.parse(fetchData.baseURL + "/orders/changeStatus/" + ID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    print(result.statusCode);
    if (result.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }

    OrderModel orderModel = OrderModel.fromJson(jsonDecode(result.body));

    return orderModel;
  }

  fetchData fetch = fetchData();
  Widget getAllOrderProducts() {
    return FutureBuilder<List<dynamic>>(
        future: fetch.getOrderProducts(id),
        builder: (contxt, snapchot) {
          if (snapchot.hasData) {
            // var products =
            //     snapchot.data?.map<ProductModel>((e) => e.product).toList() ?? [];
            List<ProductModel> products = snapchot.data!
                .map((product) => ProductModel.fromJson(product["product"]))
                .toList();
            print(products[0].toJson());

            return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return myorders(
                    products[index].id,
                    products[index].name,
                    products[index].price,
                    products[index].avatar,
                    snapchot.data![index]['size'],
                  );
                });
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ));
          }
        });
  }

  Widget myorders(id, name, price, avatar, size) {
    return Column(
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
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
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
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        name,
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
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        price.toString() + ' NIS',
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
                        size,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 20,
        ),
        //كبسة ارسال الطلب
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    totalController.text = total.toString();
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
           
        body: Column(
          children: [
            Expanded(child: getAllOrderProducts()),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(15),
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
                width: double.infinity,
                height: 120,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Text(
                            'مجموع السعر : '.tr,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                            width: 100,
                            child: TextField(
                              enabled: false,
                              controller: totalController,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.blueAccent, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          changeOrderStatus(id);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ارسال الطلب",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.delivery_dining_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ));
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
          Row(
            children: [
              Text("تم ارسال الطلب"),
              SizedBox(
                width: 7,
              ),
              Icon(
                Icons.delivery_dining,
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

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopkeeperNewOrdersScreen()));
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  void onNotification() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShopkeeperNewOrdersScreen()));
  }
}

//--------------------------------------------------------------------------
