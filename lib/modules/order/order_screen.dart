import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/products/products_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:http/http.dart' as http;

var products_list;
//var products_IDS =  [];

var price;
int points = 0;
var id_List;
int usedPoints = 0;

class OrderScreen extends StatefulWidget {
  setPoints(int P) {
    points = P;
  }

  setPrice(P) {
    price = P;
  }

  setProducts(P) {
    products_list = P;
  }

  setID(ID) {
    id_List = ID;
  }

  setUsedPoints(int U) {
    usedPoints = U;
  }

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var city;
  var sizes = "....";

  final items = [
    'القدس',
    'رام الله',
    "نابلس",
    "بيت لحم",
    "طولكرم",
    "قلقيلية",
    "الخليل",
    "سلفيت",
    "الداخل"
  ];

  final sizes_items = [
    'Small (S)',
    'Medium (M)',
    "Large (L)",
    "Extra Large (XL)",
    "Double Extra Large (XXL)",
    "...."
  ];
  String? value;
  String? value2;

  Future<OrderModel> createOrder(id, price, UsedPoints) async {
    var ID = id;
    if (nameController.text == '' ||
        phoneController.text == '' ||
        city == null ||
        sizes == '' ||
        addressController.text == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog5(context),
      );
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var body = jsonEncode({
      'buyerName': nameController.text,
      'buyerPhone': phoneController.text,
      'buyerCity': city,
      'buyerAddress': addressController.text,
      'price': price,
      'size': sizes
    });

    var result = await http.post(
        Uri.parse(fetchData.baseURL +
            "/createOrder/" +
            ID.toString() +
            "/" +
            UsedPoints.toString()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        },
        body: body);

    print('my status code ' + result.statusCode.toString());

    if (result.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }

    OrderModel orderModel = OrderModel.fromJson(jsonDecode(result.body));

    return orderModel;
  }

  Future<void> createCartOrder(UsedPoints, products_ID) async {
    if (nameController.text == '' ||
        phoneController.text == '' ||
        city == null ||
        sizes == '' ||
        addressController.text == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog5(context),
      );
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    // print(jsonEncode(products));

    var body = jsonEncode({
      'buyerName': nameController.text,
      'buyerPhone': phoneController.text,
      'buyerCity': city,
      'buyerAddress': addressController.text,
      'size': sizes,
      'products': products_list
    });
    print(body);
    var result = await http.post(
        Uri.parse(
            fetchData.baseURL + "/cart/createOrder/" + UsedPoints.toString()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        },
        body: body);

    print('my status code ' + result.statusCode.toString());

    if (result.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }

    // OrderModel orderModel = OrderModel.fromJson(jsonDecode(result.body));

    // return orderModel;
  }

  Future<void> deleteFromCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.delete(
      Uri.parse(fetchData.baseURL + "/deleteProductsOnCart"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );

    print('status code ' + result.statusCode.toString());

    if (result.statusCode == 201) {
      print("Doneeeeeeeeeeeee");
    }

    // OrderModel orderModel = OrderModel.fromJson(jsonDecode(result.body));

    // return orderModel;
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
          "استكمال الطلب".tr,
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //معلومات الاتصال------------------------------------------------------------------------------------------------------
                    Text(
                      "معلومات الاتصال".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //الاسم-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "الاسم".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: nameController,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        // hintText: "البريد الالكتروني",
                        labelText: "الاسم".tr,

                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //البريد الالكتروني------------------------------------------------------------------------------------------------------
                    // Text(
                    //   "البريد الالكتروني".tr,
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    // ),
                    // TextFormField(
                    //   controller: emailController,
                    //   keyboardType: TextInputType.emailAddress,
                    //   onFieldSubmitted: (String value) {
                    //     print(value);
                    //   },
                    //   onChanged: (String value) {
                    //     print(value);
                    //   },
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "الرجاء ادخال البريد الالكتروني";
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.email),
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    //الهاتف---------------------------------------------------------------------------------------------------------------
                    Text(
                      "الهاتف".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال رقم الهاتف".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //المدينة--------------------------------------------------------------------------------------------------------------
                    Text(
                      "المدينة".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.arrow_downward_rounded),
                                    onTap: () {
                                      controller:
                                      cityController;
                                    },
                                    isExpanded: true,
                                    value: value,
                                    items: items.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() =>
                                        {this.value = value, city = value}),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //الحجم--------------------------------------------------------------------------------------------------------------
                    Text(
                      "الحجم".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(
                                        "حدد الحجم ان لزم او اتركه فارغ \" .... \" "
                                            .tr),
                                    icon: Icon(Icons.arrow_downward_rounded),
                                    onTap: () {
                                      //  انسخ ياروحي انسخ
                                    },
                                    isExpanded: true,
                                    value: value2,
                                    items:
                                        sizes_items.map(buildMenuItem).toList(),
                                    onChanged: (value2) => setState(() => {
                                          this.value2 = value2,
                                          sizes = value2!
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //العنوان--------------------------------------------------------------------------------------------------------------
                    Text(
                      "العنوان".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        labelText: "حدد مكانك بالتفصيل".tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    //ارسال-----------------------------------------------------------------------------------------------------------------
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blueAccent, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          createCartOrder(usedPoints, products_list);
                          deleteFromCart();
                        },
                        child: Text(
                          "ارسال".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
          Text("تم اتمام طلبك بنجاح".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }

  //Pub up Function(2)--------------------------------------------------------------------------------------------
  Widget _buildPopupDialog5(BuildContext context) {
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
          Text("الرجاء ادخال جميع الحقول ")
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

  //مش مهم
  void onNotification() {
    Navigator.pop(context);
  }

  //هاد الفنكشن لخيارات المدن---------------------------------------------------------------------------------
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );

  //------------------------------------------------------------------------------------------------------------
}
