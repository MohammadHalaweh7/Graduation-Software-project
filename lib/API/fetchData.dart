import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/models/order/order_model.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/models/product/product_model.dart';
import 'package:udemy_flutter/models/store/store_model.dart';

import 'package:http/http.dart' as http;

class fetchData {
  static const String baseURL = 'https://mystoreapii.herokuapp.com';

  Future<List<StoreModel>> allstores() async {
    var res = await http.get(Uri.parse(fetchData.baseURL + '/store/allinfo'));
    //  print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> alltypestores(type) async {
    // print(type);
    //print('////////////////////////////');
    var res =
        await http.get(Uri.parse(fetchData.baseURL + '/store/typeall/' + type));

    // print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<ProductModel>> allstoreproduct(id) async {
    var res =
        await http.get(Uri.parse(fetchData.baseURL + '/getproducts/' + id));
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
    // print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());
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

    // print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());

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
