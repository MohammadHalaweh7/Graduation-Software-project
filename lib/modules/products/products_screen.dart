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
var search = 'الكل';

class ProductsScreen extends StatefulWidget {
  ProductsScreen(id) {
    this.setStoreID(id);
  }

  setStoreID(ID) {
    Storeid = ID;
  }

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
    if (searchController.text == '') {
      search = 'الكل';
    } else {
      search = searchController.text;
    }
    return FutureBuilder(
        future: fetch.allstoreproduct(Storeid, search),
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
                      physics: BouncingScrollPhysics(),
                      // shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1 / 1.82,
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
      margin: EdgeInsets.only(bottom: 7, right: 3, left: 3),
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
                SizedBox(
                  height: 5,
                ),
                //هون اسم المنتج
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 0,
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
                        // OrderScreen().setID(id);
                        // OrderScreen().setPrice(price);
                        // OrderScreen().setUsedPoints(0);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OrderScreen()));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('شراء الان'.tr), // <-- Text
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

  //هون قائمة الصور الموجدوة في اعلى الصفحة
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  //للبحث
  Icon customIcon = const Icon(
    Icons.search,
    size: 35,
  );
  Widget customSearchBar = Text("المنتجات".tr);

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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    title: TextField(
                      controller: searchController,
                      onChanged: (value) =>
                          setState(() => {search = searchController.text}),
                      decoration: InputDecoration(
                        hintText: 'اكتب اسم المنتج ...'.tr,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
              });
            },
            icon: customIcon,
          )
        ],
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
              Text("تمت اضافته الى السلة ".tr),
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
          child: Text('موافق'.tr),
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
          child: Text('اغلاق'.tr),
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
              labelText: "اكتب ملاحظاتك".tr,
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
          child: Text('موافق'.tr),
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
