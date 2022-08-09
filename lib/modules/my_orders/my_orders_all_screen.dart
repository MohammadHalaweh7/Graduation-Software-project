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
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
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

class MyOrdersAllScreen extends StatefulWidget {
  @override
  State<MyOrdersAllScreen> createState() =>
      _MyOrdersAllScreenState();
}

class _MyOrdersAllScreenState extends State<MyOrdersAllScreen> {

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
          "طلباتي",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
     
      body:  
      // هاد بضم كلشي
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
                        '12121515465',
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
                                builder: (context) => MyOrdersScreen()));



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
                        'هيسسم صالح',
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
                        'سلفيت',
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
                        "كفل حارس",
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
                        "0599658777",
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
                        "haytham@gmail.com",
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
                        'المبلغ الاجمالي : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      Spacer(),
                      Text(
                        "2000 NIS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ) 
                    ],
                  ),
                  SizedBox(
                    height: 1,
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
                        "قيد التحضير",
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
    )
  
    );
  }

  

  void onNotification() {
    Navigator.pop(context);

  }
}

//--------------------------------------------------------------------------
