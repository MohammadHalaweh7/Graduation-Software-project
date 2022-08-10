import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
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

var id;
var size;
var storeName;

class MyOrdersScreen extends StatefulWidget {
  setID(ID) {
    id = ID;
  }

  setSize(S) {
    size = S;
  }

  setStoreName(Storename) {
    storeName = Storename;
  }

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  fetchData fetch = fetchData();
  Widget getAllOrderProducts() {
    return FutureBuilder(
        future: fetch.getOrderProducts(id),
        builder: (contxt, snapchot) {
          var products = snapchot.data as List<ProductModel>;
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
                  itemCount: products == null ? 0 : products.length,
                  itemBuilder: (context, index) {
                    return myorders(
                      products[index].id,
                      products[index].name,
                      products[index].price,
                      products[index].avatar,
                    );
                  });
        });
  }

  Widget myorders(id, name, price, avatar) {
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
                              name,
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

                        //سعر المنتج---------------------------------------------------------------------------------------------------------
                        Row(
                          children: [
                            Text(
                              'سعر المنتج : '.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text(
                              price.toString() + ' NIS',
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
                              size,
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
          "تفاصيل الطلب".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: Center(child: getAllOrderProducts()),
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}

//--------------------------------------------------------------------------
