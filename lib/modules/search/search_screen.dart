import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/order/order_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:universal_io/io.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:carousel_slider/carousel_slider.dart';

var Storeid;
var search = 'الكل';

class SearchScreen extends StatefulWidget {
  SearchScreen(id) {
    this.setStoreID(id);
  }

  setStoreID(ID) {
    Storeid = ID;
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
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

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    return userModel;
  }

  Widget getstoreproducts() {
    if (searchController.text == '') {
      search = 'الكل';
    } else {
      search = searchController.text;
    }
    print(search);
    return FutureBuilder(
        future: fetch.allstoreproduct(Storeid, search),
        builder: (contxt, snapchot) {
          var products = snapchot.data as List<ProductModel>;
          return snapchot.data == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1 / 1.7,
                      children: [
                        ...products.map<Widget>((product) {
                          return myproducts(
                            product.name,
                            product.description,
                            product.id,
                            product.price,
                            product.owner,
                            product.avatar,
                          );
                        }).toList(),
                      ]),
                );
        });
  }

  Widget myproducts(name, description, id, price, owner, avatar) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1.0), //(x,y)
            blurRadius: 10.0,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //صورة المنتج
          avatar == null
              ? Image.asset(
                  'assets/images/logo3.png',
                  width: double.infinity,
                  height: 200,
                )
              : Image(
                  image: MemoryImage(base64Decode(avatar)),
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
                      price.toString() + ' NIS',
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        },
                        icon: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add_shopping_cart_outlined,
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
                      onPressed: () {
                        OrderScreen().setID(id);
                        OrderScreen().setUsedPoints(0);
                        OrderScreen().setPrice(price);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderScreen()));
                      },
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
    );
  }

  //للبحث
  Icon customIcon = const Icon(
    Icons.search,
    size: 35,
  );
  Widget customSearchBar = const Text('البحث');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 35,
            )),
        automaticallyImplyLeading: false,
        title: customSearchBar,
        // centerTitle: true,
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
                        hintText: 'اكتب اسم المنتج ...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.grey,
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
      body: Center(child: getstoreproducts()),
    );
    //Center(child: Text('بحث')));
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
          Row(
            children: [
              Text("تمت اضافته الى السلة "),
              Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.blue,
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  //فنكشن مش مهم انساه
  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
