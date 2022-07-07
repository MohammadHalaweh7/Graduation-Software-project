import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/models/product_model.dart';
import 'package:udemy_flutter/models/store_model.dart';

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
    // print(type);
    //print('////////////////////////////');
    var res =
        await http.get(Uri.parse(fetchData.baseURL + '/getproducts/' + id));

    // print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());

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
}
