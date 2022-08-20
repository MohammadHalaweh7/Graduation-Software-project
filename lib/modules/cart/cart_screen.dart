import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/order/order_screen.dart';
//import 'package:udemy_flutter/modules/order/order_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var price;
  var counter;
  var i = 0;
  var prod;
  int toNumbrs = 0;

  var myPoints;
  List<List> sizes = [];
  fetchData fetch = fetchData();
  TextEditingController totalController = new TextEditingController(text: '0');
  TextEditingController countcontroller = new TextEditingController(text: '0');
  TextEditingController pointscontroller = new TextEditingController(text: '0');
  TextEditingController allpointscontroller =
      new TextEditingController(text: '0');

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

    return userModel;
  }

  Future<UserModel> removeFromCart(id) async {
    var ID = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.patch(
        Uri.parse(fetchData.baseURL + "/users/removeProductFromCart/" + ID),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));
    setState(() {});

    return userModel;
  }

  double total = 0;
  double tot = 0;

  List<ProductModel> products = [];
  Widget cartProducts() {
    return FutureBuilder(
        future: fetch.getProductsOnCart(),
        builder: (contxt, snapchot) {
          products =
              snapchot.hasData ? snapchot.data as List<ProductModel> : [];
          if (sizes.isEmpty) {
            sizes = products.map((e) => {e.id, null}.toList()).toList();
          }
          Future.delayed(Duration(milliseconds: 1000), () {
            if (snapchot.hasData) {
              products.forEach((element) {
                tot += element.price;
              });
              total = tot;
              totalController.text = total.toStringAsFixed(2) + ' NIS';
              countcontroller.text = products.length.toString();
              tot = 0;
            }
          });

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
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return myCartProducts(
                      products[index].name,
                      products[index].description,
                      products[index].id,
                      products[index].price,
                      products[index].owner,
                      products[index].avatar,
                    );
                  });
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );

  Widget myCartProducts(name, description, id, price, owner, avatar) {
    final sizes_items = [
      'Small (S)',
      'Medium (M)',
      "Large (L)",
      "Extra Large (XL)",
      "Double Extra Large (XXL)",
      "...."
    ];
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
          child:
              //هاد البادينغ يحتوي على الصورة والاسم والسعر وسلة الزبالة
              Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //هاد الكونتينر للصورة
                Container(
                  width: 120,
                  height: 120,
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
                  width: 20,
                ),
                //هاد للاسم والسعر والسلة
                Expanded(
                  child: Container(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.all(0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(6)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                  "حدد الحجم ان لزم او اتركه فارغ \" .... \" "
                                      .tr),
                              icon: Icon(Icons.arrow_downward_rounded),
                              onTap: () {
                                //  انسخ ياروحي انسخ
                              },
                              isExpanded: true,
                              value: sizes
                                  .firstWhere((element) => element[0] == id)[1],
                              items: sizes_items.map(buildMenuItem).toList(),
                              onChanged: (value2) {
                                setState(() {
                                  var size = sizes.firstWhere(
                                      (element) => element[0] == id);
                                  size[1] = value2;
                                  print(sizes);
                                });
                              },
                            ),
                          ),
                        )),
                        Row(
                          children: [
                            Text(
                              'السعر : '.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              price.toString() + ' NIS',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  removeFromCart(id);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(context),
                                  );
                                },
                                icon: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: loadData(),
      builder: (context, snapshot) {
        var account = snapshot.data;
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.white,
              ),
            ),
          );
        } else {
          allpointscontroller.text = account!.points.toString();
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
                "السلة".tr,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(child: cartProducts()),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(19),
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
                    width: double.infinity,
                    height: 147,
                    child: Column(
                      children: [
                        //مجموع السعر وعدد العناصر
                        Row(
                          children: [
                            Text(
                              'مجموع السعر : '.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                              width: 120,
                              child: TextField(
                                enabled: false,
                                controller: totalController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'عدد العناصر : '.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                              width: 50,
                              child: TextField(
                                enabled: false,
                                controller: countcontroller,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //نقاطي وكبسة استعمال
                        Row(
                          children: [
                            Text(
                              'نقاطي : '.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 25,
                              width: 50,
                              child: TextField(
                                enabled: false,
                                controller: allpointscontroller,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 70,
                              height: 25,
                              child: TextFormField(
                                controller: pointscontroller,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                onChanged: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 85,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                color: Colors
                                    .blueAccent, // width: double.infinity,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  print(pointscontroller.text);
                                  if (account.points < 50) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialog4(context),
                                    );
                                  } else {
                                    if (int.parse(pointscontroller.text) ==
                                        50) {
                                      // for (int i = 0;
                                      //     i < products.length;
                                      //     i++) {
                                      //   products[i].price =
                                      //       products[i].price * 0.97;
                                      // }
                                      if (sizes.any(
                                          (element) => (element[1] != null))) {
                                        OrderScreen().setUsedPoints(
                                            int.parse(pointscontroller.text));
                                        OrderScreen().setPoints(account.points);
                                        OrderScreen().setProducts(sizes);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderScreen()));
                                      }
                                    } else if (int.parse(
                                            pointscontroller.text) ==
                                        100) {
                                      // for (int i = 0;
                                      //     i < products.length;
                                      //     i++) {
                                      //   products[i].price =
                                      //       products[i].price * 0.94;
                                      // }
                                      if (sizes.any(
                                          (element) => (element[1] != null))) {
                                        OrderScreen().setUsedPoints(
                                            int.parse(pointscontroller.text));
                                        OrderScreen().setPoints(account.points);
                                        OrderScreen().setProducts(sizes);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderScreen()));
                                      }
                                    } else if (int.parse(
                                            pointscontroller.text) ==
                                        150) {
                                      // for (int i = 0;
                                      //     i < products.length;
                                      //     i++) {
                                      //   products[i].price =
                                      //       products[i].price * 0.90;
                                      // }

                                      if (sizes.any(
                                          (element) => (element[1] != null))) {
                                        OrderScreen().setUsedPoints(
                                            int.parse(pointscontroller.text));
                                        OrderScreen().setPoints(account.points);
                                        OrderScreen().setProducts(sizes);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderScreen()));
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialog5(context),
                                      );
                                    }
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "استعمال".tr,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //كبسة استكمال الطلب
                        Container(
                          width: double.infinity,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.blueAccent, // width: double.infinity,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              print(sizes);
                              if (sizes
                                  .any((element) => (element[1] != null))) {
                                OrderScreen().setUsedPoints(0);
                                OrderScreen().setProducts(sizes);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderScreen()));
                              } else {
                                print('object');
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "استكمال الطلب".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.border_color,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        }
      },
    );
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
              Text("تمت ازالته من السلة ".tr),
              Icon(
                Icons.remove_shopping_cart,
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

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => ShopLayout()));
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  //Pub up Function(2)--------------------------------------------------------------------------------------------
  Widget _buildPopupDialog2(BuildContext context) {
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
          Text("تم استعمال كود الخصم".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  //Pub up Function(3)--------------------------------------------------------------------------------------------
  Widget _buildPopupDialog3(BuildContext context) {
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
          Text("تم استعمال النقاط".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }

  Widget _buildPopupDialog4(BuildContext context) {
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
          Text("يجب ان يكون لديك على الاقل 50 نقطة , نقاطك لا تكفي ".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }

  Widget _buildPopupDialog5(BuildContext context) {
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
          Text("يجب ان تستعمل 50 او 100 او 150 نقاط لاكمال هذه العملية ".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  void onNotification() {
    Navigator.pop(context);
  }
}



//--------------------------------------------------------------------------

