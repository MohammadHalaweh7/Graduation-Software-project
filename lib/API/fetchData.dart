import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/models/store/store_model.dart';

import 'package:http/http.dart' as http;

import '../models/notification/notification_model.dart';

class fetchData {
  static const String baseURL = 'https://mystoreapii.herokuapp.com';

  Future<List<StoreModel>> allstores() async {
    var res = await http.get(Uri.parse(fetchData.baseURL + '/store/allinfo'));

    var body = jsonDecode(res.body) as List<dynamic>;
    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> allCityStores(city) async {
    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/store/locationall/' + city));
    var body = jsonDecode(res.body) as List<dynamic>;
    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> allCityAndInterests(city) async {
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
    print(body);
    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> alltypestores(type) async {
    var res =
    await http.get(Uri.parse(fetchData.baseURL + '/store/typeall/' + type));

    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> alltypeCitystores(type, city) async {
    var res = await http.get(Uri.parse(
        fetchData.baseURL + '/store/CityAndType/' + city + '/' + type));

    var body = jsonDecode(res.body) as List<dynamic>;

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

  Future<List<OrderModel>> getorders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var res = await http
        .get(Uri.parse(fetchData.baseURL + '/orders/getAll'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });

    var body = jsonDecode(res.body) as List<dynamic>;

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
}