import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/store/store_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/profile/profileShop_screen.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../aboutUs/about_us_screen.dart';
import '../account/account_screen.dart';
import '../home/main_screen.dart';
import '../my_orders/my_orders_all_screen.dart';
import '../notification/notification_screen.dart';

var type = '';
var title;
var city;
var search = 'all';

class ShopsScreen extends StatefulWidget {
  setType(S) {
    type = S;
    //  print(type);
  }

  setTitle(S) {
    title = S;
    //  print(type);
  }

  setCity(S) {
    city = S;
    //  print(type);
  }

  String getType() {
    // print(type);
    return type;
  }

  String getTitle() {
    // print(type);
    return title;
  }

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  var searchController = TextEditingController();
  fetchData fetch = fetchData();

  Widget fetchTypeStores() {
    if (searchController.text == '') {
      search = 'all';
    } else {
      search = searchController.text;
    }
    return FutureBuilder(
        future: (ShopsScreen().getType() != '')
            ? fetch.alltypeCitystores(ShopsScreen().getType(), city, search)
            : (fetch.allCityStores(city, search)),
        builder: (contxt, snapchot) {
          var stores = snapchot.data as List<StoreModel>;
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
                  itemCount: stores == null ? 0 : stores.length,
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
                    );
                  });
        });
  }

  Widget mystore(name, description, id, phoneNumber, locationOnMap, avatar,
      detailedLocation, facebook, snapchat, whatsapp, instagram) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GestureDetector(
        onTap: () {
          ShopLayout().setData(
            id,
            name,
            description,
            phoneNumber,
            detailedLocation,
            facebook,
            snapchat,
            whatsapp,
            instagram,
            locationOnMap,
            avatar,
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShopLayout()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1.0), //(x,y)
                blurRadius: 10.0,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: 391,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: avatar == null
                            ? (AssetImage(
                                'assets/images/logo3.png',
                              ) as ImageProvider)
                            : MemoryImage(
                                base64Decode(avatar),
                              ),
                        fit: BoxFit.cover),
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 25,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   width: double.infinity,
              //   height: 1,
              //   color: Colors.grey,
              // )
            ],
          ),
        ),
      ),
    );
  }

  //للبحث
  Icon customIcon = const Icon(
    Icons.search,
    size: 35,
  );

  Widget customSearchBar = Text(ShopsScreen().getTitle());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        // title: Text(
        //   ShopsScreen().getTitle(),
        //   style: TextStyle(
        //     color: Colors.blue,
        //     fontSize: 22,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),

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
                        hintText: 'اكتب اسم المتجر ...'.tr,
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
       
      body: Center(child: fetchTypeStores()),
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}
