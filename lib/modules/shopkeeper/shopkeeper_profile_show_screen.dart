import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';

var id;
var name;
var description;
var phoneNumber;
var locationOnMap;

class ShopkeeperProfileShowScreen extends StatefulWidget
{
  ProfileShoScreen(id, name, description, phoneNumber, locationOnMap) {
    this.setData(id, name, description, phoneNumber, locationOnMap);
  }

  setData(ID, Name, Description, Phonenumber, Locationonmap) {
    id = ID;
    name = Name;
    description = Description;
    phoneNumber = Phonenumber;
    locationOnMap = Locationonmap;
  }

  String getID() {
    return id;
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  String getLocationOnMap() {
    return locationOnMap;
  }

  @override
  State<ShopkeeperProfileShowScreen> createState() => _ShopkeeperProfileShowScreenState();
}

class _ShopkeeperProfileShowScreenState extends State<ShopkeeperProfileShowScreen> {
  var defaultText = TextStyle(color: Colors.black);

  var linkText = TextStyle(color: Colors.black);

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
        title:Icon(Icons.remove_red_eye_sharp,size: 30,) ,

        actions: [
          IconButton(
            onPressed: () {
              onNotification;
            },
            icon: Icon(
              Icons.add_alert_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              onNotification;
            },
            icon: Icon(
              Icons.menu_book,
              color: Colors.grey,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              onNotification;
            },
            icon: Icon(
              Icons.shopping_basket_sharp,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
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
                "متجراتي",
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
                  "الرئيسية",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("الى الرئيسية"),
                leading: Icon(Icons.store, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
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
                  "معلومات المستخدم",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("حسابي"),
                leading: Icon(Icons.person, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperAccountScreen()));
                },
              ),
              ListTile(
                title: Text("متجري"),
                leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperProfileScreen()));
                },
              ),
              ListTile(
                title: Text("منتجاتي"),
                leading: Icon(Icons.production_quantity_limits, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperProductsScreen()));
                },
              ),
              ListTile(
                title: Text("اضافة منتج جديد"),
                leading: Icon(Icons.add_shopping_cart, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),
              ListTile(
                title: Text("حذف المتجر نهائيا"),
                leading: Icon(Icons.highlight_remove_sharp, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),



              ListTile(
                title: Text("تسجيل خروج"),
                leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                onTap: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.remove('token');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
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
                padding: const EdgeInsets.only(left: 220),
                child: Text(
                  "التطبيق",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("اللغة"),
                leading: Icon(Icons.g_translate, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageScreen()));
                },
              ),

              ListTile(
                title: Text("عن متجراتي"),
                leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("ضبط"),
                leading: Icon(Icons.gamepad, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("سياسة الخصوصية"),
                leading: Icon(Icons.warning, color: Color(0xff758DFF)),
                onTap: () {},
              ),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              //الصورة
              Container(
                height: 340,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1.0), //(x,y)
                        blurRadius: 20.0,
                      ),
                    ],
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage('https://www.nicepng.com/png/detail/254-2540580_we-create-a-customized-solution-to-meet-all.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30)),
              ),
              //الاسم والوصف
              Container(
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
                // color: Colors.white,
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تنويرات الشروق',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        "متجر متخصص لبيع كافة مستلومات الانارة",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              //هاتف
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "هاتف",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "0599865448",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //زيارة موقعنا
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 170,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.place_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "زيارة موقعنا",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        "المعاجين",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              //فيسبوك
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "فيسبوك",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              style: linkText,
                              text: "www.facebook.com/DaffodilWomenFashion",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  var url =
                                      "https://www.facebook.com/DaffodilWomenFashion";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw " cannot load url";
                                  }
                                }),
                        ])
                    ),
                  ],
                ),
              ),

              //سناب شات
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "سناب شات",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              style: linkText,
                              text: "www.snapchat.com/DaffodilWomenFashion",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  var url =
                                      "https://www.snapchat.com/DaffodilWomenFashion";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw " cannot load url";
                                  }
                                }),
                        ])),
                  ],
                ),
              ),

              //واتس أب
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "واتس أب",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "+0098647854452",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //انستغرام
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.wysiwyg,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "انستغرام",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              style: linkText,
                              text: "www.instagram.com/DaffodilWomenFashion",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  var url =
                                      "https://www.instagram.com/DaffodilWomenFashion";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw " cannot load url";
                                  }
                                }),
                        ])),
                  ],
                ),
              ),

              //عنوان المتجر
              SizedBox(
                height: 10,
              ),
              Container(
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
                // color: Colors.white,
                height: 230,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.place_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "عنوان المتجر",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              style: linkText,
                              text: locationOnMap,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  var url = locationOnMap;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw " cannot load url";
                                  }
                                }),
                        ])),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
