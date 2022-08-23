import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/models/store/store_model.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_account_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_details_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_show_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';

import 'admin_addNotification_screen.dart';
import 'admin_profile_screen.dart';

class AdminShopsScreen extends StatefulWidget {
  @override
  State<AdminShopsScreen> createState() => _AdminShopsScreenState();
}

class _AdminShopsScreenState extends State<AdminShopsScreen> {
  fetchData fetch = fetchData();
  List<StoreModel> stores = [];
  Widget fetchAllStores() {
    return FutureBuilder(
        future: fetch.allstores(),
        builder: (contxt, snapchot) {
          stores = snapchot.hasData ? snapchot.data as List<StoreModel> : [];

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
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    return mystore(
                      stores[index].name,
                      stores[index].description,
                      stores[index].id,
                      stores[index].phoneNumber,
                      stores[index].locationOnMap,
                      stores[index].avatar,
                      stores[index].detailedLocation,
                      stores[index].facebook,
                      stores[index].snapchat,
                      stores[index].whatsapp,
                      stores[index].instagram,
                      stores[index].type,
                      stores[index].location,
                    );
                  });
        });
  }

  Widget mystore(
      name,
      description,
      id,
      phoneNumber,
      locationOnMap,
      avatar,
      detailedLocation,
      facebook,
      snapchat,
      whatsapp,
      instagram,
      type,
      location) {
    return Padding(
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
                      builder: (context) => AdminShopsShowScreen(
                          name,
                          description,
                          id,
                          phoneNumber,
                          locationOnMap,
                          avatar,
                          detailedLocation,
                          facebook,
                          snapchat,
                          whatsapp,
                          instagram,
                          type,
                          location)));
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
                    Container(
                      width: 115,
                      height: 115,
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
                        height: 113,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              // color: Colors.red,
                              width: 230,
                              child: Row(
                                children: [
                                  Text(
                                    'اسم المتجر : '.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'وصف المتجر : '.tr,
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
    ); //هاد بضم الكونتينر وكل اللي جواتو
  }

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
                                builder: (context) => AdminMainScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("الى المتاجر".tr),
                      leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminShopsScreen()));
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
                                builder: (context) => AdminAccountScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("طلبات المتاجر الجديدة".tr),
                      leading: Icon(Icons.remove_from_queue_outlined,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("ارسال اشعارات".tr),
                      leading: Icon(Icons.notification_add,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNotificationScreen()));
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
                      onTap: () {
                            Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminProfileScreen()));
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
          "المتاجر".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: fetchAllStores(),
      //     //هاد بضم الكونتينر وكل اللي جواتو
      //     GestureDetector(
      //   onTap: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => AdminShopsShowScreen()));
      //   },
      //   child:
      //       //هاد الكونتينر بضم كلشي
      //       Container(
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(15.0),
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey,
      //           offset: Offset(0, 1.0), //(x,y)
      //           blurRadius: 5.0,
      //         ),
      //       ],
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Row(
      //         children: [
      //           Container(
      //             width: 115,
      //             height: 115,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 image: DecorationImage(
      //                     image: NetworkImage(
      //                         'https://www.nicepng.com/png/detail/254-2540580_we-create-a-customized-solution-to-meet-all.png'),
      //                     fit: BoxFit.cover)),
      //           ),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           Expanded(
      //             child: Container(
      //               height: 113,
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   Row(
      //                     children: [
      //                       Text(
      //                         'اسم المتجر : ',
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.blue),
      //                       ),
      //                       Text(
      //                         'تنويرات الشروق',
      //                         maxLines: 2,
      //                         overflow: TextOverflow.ellipsis,
      //                         style: TextStyle(),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 3,
      //                   ),
      //                   Text(
      //                     'وصف المتجر : ',
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.bold, color: Colors.blue),
      //                   ),

      //                   Expanded(
      //                       child: Text(
      //                     ' متجر متخصص لبيع كافة انواع التريات والاجهزة الكهربائية والمنزلية والمنزليةوالمنزليةوالمنزلية  ',
      //                     maxLines: 2,
      //                     overflow: TextOverflow.ellipsis,
      //                   )),
      //                   // Text('${article['publishedAt']}',style: TextStyle(color: Colors.grey,fontSize: 20),),
      //                 ],
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  //مش مهم
  void onNotification() {
    Navigator.pop(context);
  }
}

//--------------------------------------------------------------------------
