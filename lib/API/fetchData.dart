import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/models/PendingPhotos/PendingPhotos_model.dart';
import 'package:udemy_flutter/models/admin/admin_model.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/models/store/store_model.dart';

import 'package:http/http.dart' as http;
import 'package:udemy_flutter/models/user/user_model.dart';

import '../main.dart';
import '../models/notification/notification_model.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../modules/shops/shops_screen.dart';

class fetchData {
  static const String baseURL = 'https://mystoreapii.herokuapp.com';

  Future<List<StoreModel>> allstores() async {
    var res = await http.get(Uri.parse(fetchData.baseURL + '/store/allinfo'));

    var body = jsonDecode(res.body) as List<dynamic>;
    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> allCityStores(city, search) async {
    var res = await http.get(Uri.parse(
        fetchData.baseURL + '/store/locationall/' + city + '/' + search));
    var body = jsonDecode(res.body) as List<dynamic>;
    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> allCityAndInterests(city) async {
// -----

// ----

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var res = await http.get(
        Uri.parse(fetchData.baseURL + '/store/locationAndInterests/' + city),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });
    print(res.statusCode);
    // print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;
    // print(body);
    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> alltypestores(type) async {
    var res =
        await http.get(Uri.parse(fetchData.baseURL + '/store/typeall/' + type));

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> alltypeCitystores(type, city, search) async {
    var res = await http.get(Uri.parse(fetchData.baseURL +
        '/store/CityAndType/' +
        city +
        '/' +
        type +
        '/' +
        search));

    var body = jsonDecode(res.body) as List<dynamic>;
    ShopsScreen().setType('');

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<NotificationModel>> allNotifications() async {
    var res =
        await http.get(Uri.parse(fetchData.baseURL + '/notifications/getAll'));

    var body = jsonDecode(res.body) as List<dynamic>;

    return body
        .map((notification) => NotificationModel.fromJson(notification))
        .toList();
  }

  Future<List<ProductModel>> allstoreproduct(id, search) async {
    var res = await http.get(
        Uri.parse(fetchData.baseURL + '/getproducts/' + id + '/' + search));
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> allSearchProduct(
      id, name, leastprice, highestprice, sortby) async {
    var res = await http.get(Uri.parse(fetchData.baseURL +
        '/getMyProducts/' +
        id +
        '/' +
        name +
        '/' +
        leastprice +
        '/' +
        highestprice +
        '/' +
        sortby));
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> allproducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/store/getproducts'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });
    print(res.statusCode);
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> getProductsOnCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/getproductsOnCart'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });
    print(res.statusCode);
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> getOrderProducts(id) async {
    var res = await http.get(
        Uri.parse(fetchData.baseURL + '/order/orderProducts/' + id),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(res.statusCode);
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<OrderModel>> getorders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/orders/getAll'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });

    var body = jsonDecode(res.body) as List<dynamic>;
    //print(res.body);
    // print(body.toString());

    return body.map((order) => OrderModel.fromJson(order)).toList();
  }

  Future<List<OrderModel>> getNeworders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/orders/storeNewOrders'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((order) => OrderModel.fromJson(order)).toList();
  }

  Future<List<OrderModel>> getInArrivalorders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http.get(
        Uri.parse(fetchData.baseURL + '/orders/storeInArrivalOrders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((order) => OrderModel.fromJson(order)).toList();
  }

  Future<List<OrderModel>> getAllStoreorders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/orders/storeAllOrders'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((order) => OrderModel.fromJson(order)).toList();
  }

  Future<List<pendingStoreModel>> allPendingStores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var res = await http.get(
        Uri.parse(fetchData.baseURL + '/admin/getAllPendingStores'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });

    var body = jsonDecode(res.body) as List<dynamic>;

    return body
        .map((pendingStore) => pendingStoreModel.fromJson(pendingStore))
        .toList();
  }

  Future<List<UserModel>> userchangeShopNotificationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http.post(
        Uri.parse(fetchData.baseURL + '/users/shopChangeNotification'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });
    print(res.body);

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((user) => UserModel.fromJson(user)).toList();
  }

  Future<List<UserModel>> userChangeAdminNotificationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http.post(
        Uri.parse(fetchData.baseURL + '/users/adminChangeNotification'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((user) => UserModel.fromJson(user)).toList();
  }

  Future<List<AdminModel>> adminchangeNotificationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http.post(
        Uri.parse(fetchData.baseURL + '/admin/notificationSeen'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        });
    print(res.body);

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((user) => AdminModel.fromJson(user)).toList();
  }

  Future<List<PendingPhotosModel>> getAllPendingAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/PendingPhotos/getAll'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });
    print(res.body);

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((Ads) => PendingPhotosModel.fromJson(Ads)).toList();
  }

  Future<List<PendingPhotosModel>> getAllAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/photos/getAll'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });
    print(res.body);

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((Ads) => PendingPhotosModel.fromJson(Ads)).toList();
  }
}
