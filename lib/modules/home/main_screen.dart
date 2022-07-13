import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/store/store_model.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shops/shops_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:http/http.dart' as http;

//Haytham Saleh
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  fetchData fetch = fetchData();

  Widget fetchAllStores() {
    return FutureBuilder(
        future: fetch.allstores(),
        builder: (contxt, snapchot) {
          var stores = snapchot.data as List<StoreModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: stores == null ? 0 : stores.length,
                  itemBuilder: (context, index) {
                    return mystore(
                      stores[index].name,
                      stores[index].description,
                      stores[index].id,
                    );
                  });
        });
  }

  Widget mystore(name, description, id) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Column(
          children: [
            Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://mystoreapii.herokuapp.com/store/' +
                            id +
                            '/avatar',
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
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    fetch.allstores();
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
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              var ScaffoldKey;
              //ScaffoldKey.currentState?.openDrawer();
              //        Navigator.push(context,MaterialPageRoute(builder: (context) => openDrawer()));
            },
            child: IconButton(
                onPressed: onNotification,
                icon: Icon(
                  Icons.menu,
                  color: Colors.blue,
                  size: 35,
                )),
          ),
          title: Text(
            "الصفحة الرئيسية",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                onNotification;
              },
              icon: Icon(
                Icons.add_alert_outlined,
                color: Colors.black54,
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
                  title: Text("الى المتاجر"),
                  leading: Icon(Icons.store, color: Color(0xff758DFF)),
                  onTap: () {},
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
                            builder: (context) => AccountScreen()));
                  },
                ),
                ListTile(
                  title: Text("منتجات أعجبتني"),
                  leading: Icon(Icons.favorite, color: Color(0xff758DFF)),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("منتجات طلبتها"),
                  leading: Icon(Icons.add_chart, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrdersScreen()));
                  },
                ),
                ListTile(
                  title: Text("منتجات شاهدتها"),
                  leading: Icon(Icons.remove_red_eye_outlined,
                      color: Color(0xff758DFF)),
                  onTap: () {},
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
                  title: Text("للانضمام الى متجراتي"),
                  leading: Icon(Icons.person_add, color: Color(0xff758DFF)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinAppScreen()));
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
                ListTile(
                  title: Text("قيم هذا التطبيق"),
                  leading: Icon(Icons.star, color: Color(0xff758DFF)),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                      "تسوق حسب الفئة",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopsScreen()));
                      },
                      child: Text("عرض الكل"),
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
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("للأطفال");
                                ShopsScreen().setType('children');
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
                              "للأطفال",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("للسيدات");
                                ShopsScreen().setType('women');
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
                              "للسيدات",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("للرجال");
                                ShopsScreen().setType('للرجال');
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
                              "للرجال",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("اكسسوارات");
                                ShopsScreen().setType('accessories');
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
                              "اكسسوارات",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("هدايا");
                                ShopsScreen().setType('gifts');
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
                                      AssetImage('assets/images/gifts.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "هدايا",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("ماكولات");
                                ShopsScreen().setType('food');
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
                              "ماكولات",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("ملابس");
                                ShopsScreen().setType('clothes');
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
                              "ملابس",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("أحذية");
                                ShopsScreen().setType('shoes');
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
                              "أحذية",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("عطور");
                                ShopsScreen().setType('perfumes');
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
                              "عطور",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Container(
                        width: 90,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ShopsScreen().setTitle("فنون");
                                ShopsScreen().setType('art');
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
                                      AssetImage('assets/images/art.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "فنون",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0,
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
                      "متاجراخترناها لك",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text("عرض الكل"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //المتاجر------------------------------------------------------
              Container(height: 270, child: fetchAllStores()),
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
                      "متاجر جديدة",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 205,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text("عرض الكل"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //المتاجر------------------------------------------------------
              Container(height: 300, child: fetchAllStores()),
            ],
          ),
        ));
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
