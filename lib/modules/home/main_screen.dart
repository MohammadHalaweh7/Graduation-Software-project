import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/store/store_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/aboutUs/about_us_screen.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_all_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
import 'package:udemy_flutter/modules/notification/notification_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shops/shops_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/shared/cubit/cubit.dart';

import '../../layout/shop_layout/shop_layout.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../main.dart';

var shopNotification;
var adminNotification;

//Haytham Saleh
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

late String deviceToken;

class _MainScreenState extends State<MainScreen> {
  var fbm = FirebaseMessaging.instance;

  fetchData fetch = fetchData();

  String? city = 'الكل'.tr;
  final citiesItems = [
    'الكل'.tr,
    'القدس'.tr,
    'راماالله'.tr,
    "نابلس".tr,
    "بيت لحم".tr,
    "طولكرم".tr,
    "قلقيلية".tr,
    "الخليل".tr,
    "سلفيت".tr,
    "الداخل".tr
  ];
  String? value2;
  String? value3;
  List<StoreModel> stores = [];
  Future<UserModel> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/users/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    print(result.statusCode);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    shopNotification = userModel.NotificationFromShop;
    adminNotification = userModel.NotificationFromAdmin;

    return userModel;
  }

  Widget fetchAllStores() {
// -------------------------------
    loadData();
    print(adminNotification);
    if (shopNotification == true) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.pink,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("${notification.title}"),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("${notification.body}")],
                    ),
                  ),
                );
              });
        }
      });
      flutterLocalNotificationsPlugin.show(
          0,
          "Imprtant Meassge!",
          "You have new messages from shops",
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher')));

      //change state of notification
      fetch.userchangeShopNotificationState();
    }
    if (adminNotification == true) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.pink,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("${notification.title}"),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("${notification.body}")],
                    ),
                  ),
                );
              });
        }
      });
      flutterLocalNotificationsPlugin.show(
          0,
          "Imprtant Meassge!",
          "You have new messages from admin",
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher')));

      //change state of notification
      fetch.userChangeAdminNotificationState();
    }

// -----------

    return FutureBuilder(
        future: fetch.allCityAndInterests(city),
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
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: stores == null ? 0 : stores.length,
                  itemBuilder: (context, index) {
                    print(stores.length);
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
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShopLayout()));
              },
              child: Container(
                width: 200,
                child: Column(
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              offset: Offset(1, 1.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                          border: Border.all(color: Colors.grey),
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
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17,
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Text(description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ));
  }

  @override
  void initState() {
    print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');

    fbm.getToken().then((token) {
      deviceToken = token.toString();
      print(deviceToken);
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
    });

    // TODO: implement initState
    // fetch.allstores();
    super.initState();
  }

  final List<String> imgList = [
    'https://www.cmarix.com/blog/wp-content/uploads/2020/07/The-best-eCommerce-platform-for-Food-delivery.png',
    'https://www.nicepng.com/png/detail/254-2540580_we-create-a-customized-solution-to-meet-all.png',
    'https://previews.123rf.com/images/pongsirionkham/pongsirionkham2004/pongsirionkham200400021/144173188-delivery-boy-ride-wearing-a-red-shirt-and-pink-scooter-motorcycle-from-the-store-s-mobile-to-the-cus.jpg?fj=1'
        'https://img.freepik.com/premium-vector/fast-delivery-by-scooter-mobile-e-commerce-concept-online-food-pizza-order-packaging-box-infographic_131114-3.jpg?w=2000',
    'https://img.freepik.com/free-vector/online-shopping-banner-mobile-app-templates-concept-flat-design_1150-34867.jpg?w=2000',
    'https://img.freepik.com/premium-vector/transaction-people-character-concept-flat-style-investor-bring-money-ideas-online_75841-1.jpg?w=2000'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // backgroundColor: Colors.white,
            leading: Builder(
              builder: (context) => IconButton(
                icon: new Icon(
                  Icons.menu,
                  size: 35,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: Text(
              "الصفحة الرئيسية".tr,
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(top: 8, left: 7),
                width: 100,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        margin: EdgeInsets.all(0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(6)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            onTap: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            isExpanded: true,
                            value: value3,
                            items: citiesItems.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(
                                () => {this.value3 = value, city = value}),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(
                    Icons.brightness_4_rounded,
                    size: 30,
                  )),
            ]),
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
                  "متجراتي".tr,
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
                  title: Text("عن متجراتي".tr),
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
                    prefs.remove('admintoken');
                    prefs.remove('storetoken');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                items: imgList
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                e,
                                height: 200,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                //   //خصائصها

                options: CarouselOptions(
                  height: 217,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  // initialPage: 0,
                  // viewportFraction: 0.85,
                  // reverse: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  // scrollDirection: Axis.horizontal,
                ),
              ),

              //تسوق حسب الفئة------------------------------------------------------
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 5,
                      height: 40,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "تسوق حسب الفئة".tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //List of type--------------------------------------------------------
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 120,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("للأطفال - ".tr + city!);
                                ShopsScreen().setType('للأطفال');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/baby.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "للأطفال".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("للسيدات - ".tr + city!);
                                ShopsScreen().setType('للسيدات');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/women.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "للسيدات".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("للرجال - ".tr + city!);
                                ShopsScreen().setType('للرجال');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/man.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "للرجال".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("انارة - ".tr + city!);
                                ShopsScreen().setType('انارة');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/lights.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "انارة".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("أحذية - ".tr + city!);
                                ShopsScreen().setType('أحذية');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/shoes.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "أحذية".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("ملابس - ".tr + city!);
                                ShopsScreen().setType('ملابس');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/clothes.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "ملابس".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("عطور - ".tr + city!);
                                ShopsScreen().setType('عطور');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/perfumes.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "عطور".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen()
                                    .setTitle("الكترونيك - ".tr + city!);
                                ShopsScreen().setType('الكترونيك');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: AssetImage(
                                      'assets/images/electronics.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "الكترونيك".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen()
                                    .setTitle("اكسسوارات - ".tr + city!);
                                ShopsScreen().setType('اكسسوارات');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: AssetImage(
                                      'assets/images/Accessories.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "اكسسوارات".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("ماكولات - ".tr + city!);
                                ShopsScreen().setType('ماكولات');
                                ShopsScreen().setCity(city);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopsScreen()));
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(35),
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage:
                                      AssetImage('assets/images/food.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "ماكولات".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //متاجراخترناها لك------------------------------------------------------
              Container(
                margin: EdgeInsets.only(top: 0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 5,
                      height: 40,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "متاجراخترناها لك".tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        ShopsScreen().setTitle(
                          city,
                        );
                        ShopsScreen().setCity(
                          city,
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopsScreen()));
                      },
                      child: Text(
                        "عرض الكل".tr,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //المتاجر------------------------------------------------------
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Container(height: 290, child: fetchAllStores()),
              ),
              SizedBox(
                height: 10,
              ),
              //متاجر جديدة ------------------------------------------------------
              Container(
                margin: EdgeInsets.only(top: 0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 5,
                      height: 40,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "متاجر جديدة".tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        ShopsScreen().setTitle(
                          city,
                        );
                        ShopsScreen().setCity(
                          city,
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopsScreen()));
                      },
                      child: Text(
                        "عرض الكل".tr,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //المتاجر------------------------------------------------------
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Container(height: 300, child: fetchAllStores()),
              ),
            ],
          ),
        ));
  }

  //هاد الفنكشن لخيارات الفئة---------------------------------------------------------------------------------
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
  //--------------------------------------------------------------------------------------------------

  void onNotification() {
    // Scaffold.currentState?.openDrawer();
  }
}
