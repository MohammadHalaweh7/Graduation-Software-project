import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/product_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:universal_io/io.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:carousel_slider/carousel_slider.dart';

var Storeid;

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
  fetchData fetch = fetchData();
  var prod;

  Future<UserModel> addToCart(id) async {
    var ID = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    print(token);

    var result = await http.patch(
        Uri.parse(fetchData.baseURL + "/users/addProductOnCart/" + ID),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });

    // print(result);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    return userModel;
  }

  Widget getstoreproducts() {
    return FutureBuilder(
        future: fetch.allstoreproduct(Storeid),
        builder: (contxt, snapchot) {
          var products = snapchot.data as List<ProductModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: products == null ? 0 : products.length,
                  itemBuilder: (context, index) {
                    return myproducts(
                      products[index].name,
                      products[index].description,
                      products[index].id,
                      products[index].price,
                      products[index].owner,
                    );
                  });
        });
  }

  Widget myproducts(name, description, id, price, owner) {
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
        childAspectRatio: 1 / 1.7,
        children: List.generate(
          2,
          (index) => Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //صورة المنتج
                Image(
                  image: NetworkImage(
                      'https://mystoreapii.herokuapp.com/product/' +
                          id +
                          '/avatar'),
                  width: double.infinity,
                  height: 200,
                ),
                //هون الاسم والسعر والمفضلة والكبسة شراء الان
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //هون اسم المنتج
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      //هون السعر والمفضلة
                      Row(
                        children: [
                          Text(
                            price,
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
                              },
                              icon: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
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
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('شراء الان'), // <-- Text
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
          ),
        ),
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
          "المنتجات",
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
      body: getstoreproducts(),

      // SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     physics: BouncingScrollPhysics(),
      //     child: Column(
      //       children: <Widget>[
      //         // SizedBox(
      //         //   height: 10,
      //         // ),
      //         //الصور اللي بتتحرك باعلى الصفحة
      //         // CarouselSlider(
      //         //   items: imgList
      //         //       .map((e) => ClipRRect(
      //         //             borderRadius: BorderRadius.circular(6),
      //         //             child: Stack(
      //         //               fit: StackFit.expand,
      //         //               children: [
      //         //                 Image.network(
      //         //                   e,
      //         //                   height: 200,
      //         //                   width: 100,
      //         //                   fit: BoxFit.cover,
      //         //                 ),
      //         //               ],
      //         //             ),
      //         //           ))
      //         //       .toList(),
      //         //   //خصائصها
      //         //   options: CarouselOptions(
      //         //     height: 250,
      //         //     autoPlay: true,
      //         //     enableInfiniteScroll: true,
      //         //     enlargeCenterPage: true,
      //         //     // initialPage: 0,
      //         //     // viewportFraction: 0.85,
      //         //     // reverse: false,
      //         //     autoPlayInterval: Duration(seconds: 1),
      //         //     autoPlayAnimationDuration: Duration(seconds: 1),
      //         //     // autoPlayCurve: Curves.fastOutSlowIn,
      //         //     // scrollDirection: Axis.horizontal,
      //         //   ),
      //         // ),
      //         // SizedBox(
      //         //   height: 10,
      //         // ),
      //         //  هون المنتجات

      //         getstoreproducts(),
      //         // Container(
      //         //   color: Colors.grey[300],
      //         //   child: GridView.count(
      //         //     shrinkWrap: true,
      //         //     physics: NeverScrollableScrollPhysics(),
      //         //     crossAxisCount: 2,
      //         //     mainAxisSpacing: 7,
      //         //     crossAxisSpacing: 7,
      //         //     childAspectRatio: 1 / 1.7,
      //         //     children: List.generate(
      //         //       10,
      //         //       (index) => Container(
      //         //         color: Colors.white,
      //         //         child: Column(
      //         //           crossAxisAlignment: CrossAxisAlignment.start,
      //         //           children: [
      //         //             //صورة المنتج
      //         //             Image(
      //         //               image: NetworkImage(
      //         //                   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
      //         //               width: double.infinity,
      //         //               height: 200,
      //         //             ),
      //         //             //هون الاسم والسعر والمفضلة والكبسة شراء الان
      //         //             Padding(
      //         //               padding: const EdgeInsets.only(left: 12, right: 12),
      //         //               child: Column(
      //         //                 crossAxisAlignment: CrossAxisAlignment.start,
      //         //                 children: [
      //         //                   //هون اسم المنتج
      //         //                   Text(
      //         //                     'Nokia',
      //         //                     maxLines: 1,
      //         //                     overflow: TextOverflow.ellipsis,
      //         //                     style: TextStyle(
      //         //                       fontSize: 14,
      //         //                     ),
      //         //                   ),
      //         //                   SizedBox(
      //         //                     height: 13,
      //         //                   ),
      //         //                   //هون السعر والمفضلة
      //         //                   Row(
      //         //                     children: [
      //         //                       Text(
      //         //                         '599',
      //         //                         style: TextStyle(
      //         //                           fontSize: 15,
      //         //                           color: Colors.blue,
      //         //                         ),
      //         //                       ),
      //         //                       Spacer(),
      //         //                       //جديد جديد جديد
      //         //                       IconButton(
      //         //                           padding: EdgeInsets.zero,
      //         //                           onPressed: () {},
      //         //                           icon: CircleAvatar(
      //         //                               radius: 17,
      //         //                               backgroundColor: Colors.blue,
      //         //                               child: Icon(
      //         //                                 Icons.shopping_cart_outlined,
      //         //                                 color: Colors.white,
      //         //                               )))

      //         //                       //  لهون
      //         //                     ],
      //         //                   ),
      //         //                   //كبسة شراء الان
      //         //                   Container(
      //         //                     margin: EdgeInsets.only(right: 0),
      //         //                     child: SizedBox(
      //         //                       width: 210,
      //         //                       child: ElevatedButton(
      //         //                         style: ElevatedButton.styleFrom(
      //         //                           primary: Colors.blue,
      //         //                           elevation: 20,
      //         //                         ),
      //         //                         onPressed: () {},
      //         //                         child: Row(
      //         //                           mainAxisSize: MainAxisSize.min,
      //         //                           children: [
      //         //                             Text('شراء الان'), // <-- Text
      //         //                             SizedBox(
      //         //                               width: 10,
      //         //                             ),
      //         //                             Icon(
      //         //                               // <-- Icon
      //         //                               Icons.shopping_cart_outlined,
      //         //                               size: 24.0,
      //         //                             ),
      //         //                           ],
      //         //                         ),
      //         //                       ),
      //         //                     ),
      //         //                   ),
      //         //                 ],
      //         //               ),
      //         //             ),
      //         //           ],
      //         //         ),
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
      //       ],
      //     )),
    );
  }

  //فنكشن مش مهم انساه
  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
