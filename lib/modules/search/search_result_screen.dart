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
import 'package:udemy_flutter/modules/search/search_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:universal_io/io.dart';
import "package:url_launcher/url_launcher.dart";
import '../../layout/shop_layout/shop_layout.dart';
import '../../src/my_app.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../aboutUs/about_us_screen.dart';
import '../account/account_screen.dart';
import '../home/main_screen.dart';
import '../my_orders/my_orders_all_screen.dart';
import '../notification/notification_screen.dart';

var Storeid;
var LeastPrice;
var HighestPrice;
var SortBy;
var name;
var search = 'الكل';

class SearhResultScreen extends StatefulWidget {
  setStoreID(ID) {
    Storeid = ID;
  }

  setname(N) {
    name = N;
  }

  setLeastPrice(LP) {
    LeastPrice = LP;
  }

  setHighestPrice(HP) {
    HighestPrice = HP;
  }

  setSortBy(SB) {
    SortBy = SB;
  }

  @override
  State<SearhResultScreen> createState() => _SearhResultScreenState();
}

class _SearhResultScreenState extends State<SearhResultScreen> {
  final sizes_items = [
    'Small (S)',
    'Medium (M)',
    "Large (L)",
    "Extra Large (XL)",
    "Double Extra Large (XXL)",
    "...."
  ];
  List<List> sizes = [];
  var searchController = TextEditingController();
  var sizeController = TextEditingController();
  fetchData fetch = fetchData();
  var prod;

  Future<UserModel> addToCart(id) async {
    var ID = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    print(token);

    var result = await http.patch(
        Uri.parse(fetchData.baseURL + "/users/addProductOnCart/" + ID),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    return userModel;
  }

  Widget getstoreproducts() {
    return FutureBuilder(
        future: fetch.allSearchProduct(
            Storeid, name, leastPrice, highestPrice, sortBY),
        builder: (contxt, snapchot) {
          var products = snapchot.data as List<ProductModel>;
          return snapchot.data == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1 / 1.9,
                      children: [
                        ...products.map<Widget>((product) {
                          return myproducts(
                            product.name,
                            product.description,
                            product.id,
                            product.price,
                            product.owner,
                            product.avatar,
                          );
                        }).toList(),
                      ]),
                );
        });
  }

  Widget myproducts(name, description, id, price, owner, avatar) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1.0), //(x,y)
            blurRadius: 10.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //صورة المنتج
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog2(avatar, description),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: avatar == null
                          ? (AssetImage(
                              'assets/images/logo3.png',
                            ) as ImageProvider)
                          : MemoryImage(base64Decode(avatar)),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          //هون الاسم والسعر والمفضلة والكبسة شراء الان
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //هون اسم المنتج
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                //هون السعر والمفضلة
                Row(
                  children: [
                    Text(
                      price.toString() + ' NIS',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    Spacer(),
                    //جديد جديد جديد
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          addToCart(id);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        },
                        icon: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add_shopping_cart_outlined,
                              color: Colors.white,
                            )))

                    //  لهون
                  ],
                ),
                //كبسة شراء الان
                Container(
                  margin: EdgeInsets.only(right: 0),
                  child: SizedBox(
                    width: 210,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        elevation: 20,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog5(id, price),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('شراء الان'), // <-- Text
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            // <-- Icon
                            Icons.shopping_cart_outlined,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customSearchBar = const Text('نتيجة البحث');

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
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 35,
            )),
        title: customSearchBar,
        //كبسة السيرش
        actions: [],
      ),
      body: Center(child: getstoreproducts()),
    );
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
              Text("تمت اضافته الى السلة "),
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

  //Pub up Function--------------------------------------------------------------------------------------------
  Widget _buildPopupDialog2(avatar, description) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: avatar == null
                        ? (AssetImage(
                            'assets/images/logo3.png',
                          ) as ImageProvider)
                        : MemoryImage(base64Decode(avatar)),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: const Text('اغلاق'),
        ),
      ],
    );
  }

  Widget _buildPopupDialog5(id, price) {
    var products = [id];
    if (sizes.isEmpty) {
      sizes = products.map((e) => {id, null}.toList()).toList();
    }
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: sizeController,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            maxLength: 1000,
            decoration: InputDecoration(
              labelText: "اكتب ملاحظاتك",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            sizes.firstWhere((element) => element[0] == id)[1];
            if (sizeController.text != '') {
              var size = sizes.firstWhere((element) => element[0] == id);
              size[1] = sizeController.text;
              print(sizes);
              OrderScreen().setProducts(sizes);
              OrderScreen().setPrice(price);
              OrderScreen().setUsedPoints(0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderScreen()));
              sizes = products.map((e) => {id, null}.toList()).toList();
              sizeController.text = '';
            }
          },
          textColor: Colors.blue,
          child: Text('موافق'),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
  //-----------------------------------------------------------------------------------------------------------

  //فنكشن مش مهم انساه
  void onNotification() {
    Navigator.pop(context);
  }
}
