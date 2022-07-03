import 'dart:convert';

import 'package:udemy_flutter/models/store_model.dart';

import 'package:http/http.dart' as http;

class fetchData {
  static const String baseURL = 'https://mystoreapii.herokuapp.com';

  Future<List<StoreModel>> allstores() async {
    var res = await http.get(Uri.parse(fetchData.baseURL + '/store/allinfo'));
    print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }

  Future<List<StoreModel>> alltypestores(type) async {
    // print(type);
    //print('////////////////////////////');
    var res =
        await http.get(Uri.parse(fetchData.baseURL + '/store/typeall/' + type));

    print(res.body);
    var body = jsonDecode(res.body) as List<dynamic>;

    // print(body.toString());

    return body.map((store) => StoreModel.fromJson(store)).toList();
  }
}
