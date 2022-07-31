import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/order/order_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  fetchData fetch = fetchData();
  Widget getAllOrders() {
    return FutureBuilder(
        future: fetch.getorders(),
        builder: (contxt, snapchot) {
          var orders = snapchot.data as List<OrderModel>;
          return snapchot.data == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: orders == null ? 0 : orders.length,
                  itemBuilder: (context, index) {
                    return myorders(
                      orders[index].orderNumber,
                      orders[index].storeName,
                      orders[index].productName,
                      orders[index].price,
                      orders[index].orderStatus,
                      orders[index].id,
                      orders[index].avatar,
                    );
                  });
        });
  }

  Widget myorders(
      orderNumber, storeName, productName, price, orderStatus, id, avatar) {
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                              'رقم الطلب : '.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              orderNumber,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
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
                        //صورة المتجر---------------------------------------------------------------------------------------------------------
                        Row(
                          children: [
                            Text(
                              'صورة المنتج : '.tr,
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
                          height: 13,
                        ),
                        //اسم المتجر---------------------------------------------------------------------------------------------------------
                        Row(
                          children: [
                            Text(
                              'اسم المتجر : '.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text(
                              storeName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // اسم المنتج---------------------------------------------------------------------------------------------------------
                        Row(
                          children: [
                            Text(
                              'اسم المنتج : '.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text(
                              productName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
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
                              'المبلغ الاجمالي : '.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text(
                              price + ' NIS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //الحجم---------------------------------------------------------------------------------------------------------
                        Row(
                          children: [
                            Text(
                              'الحجم : '.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text(
                              "....",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // حالة الطلب---------------------------------------------------------------------------------------------------------
                        Row(
                          children: [
                            Text(
                              'حالة الطلب : '.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text(
                              orderStatus,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 5,
        )
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
          "منتجات طلبتها".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: Center(child: getAllOrders()),
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}

//--------------------------------------------------------------------------
