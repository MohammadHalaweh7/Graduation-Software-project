import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/PendingPhotos/PendingPhotos_model.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AdminAllPosterScreen extends StatefulWidget {
  @override
  State<AdminAllPosterScreen> createState() => _AdminAllPosterScreenState();
}

class _AdminAllPosterScreenState extends State<AdminAllPosterScreen> {
  get avatar => null; // for test

  fetchData fetch = fetchData();

  Future<void> deleteAds(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var result = await http
        .post(Uri.parse(fetchData.baseURL + '/photos/delete/' + id), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    });

    print(result.statusCode);

    if (result.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog2(context),
      );
    }
  }

  List<PendingPhotosModel> pendingPhotos = [];
  Widget fetchAllAds() {
    return FutureBuilder(
        future: fetch.getAllAds(),
        builder: (contxt, snapchot) {
          pendingPhotos =
              snapchot.hasData ? snapchot.data as List<PendingPhotosModel> : [];

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
                  itemCount: pendingPhotos.length,
                  itemBuilder: (context, index) {
                    return myAds(
                      pendingPhotos[index].email,
                      pendingPhotos[index].storename,
                      pendingPhotos[index].id,
                      pendingPhotos[index].photo,
                    );
                  });
        });
  }

  Widget myAds(email, storename, id, photo) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1.0), //(x,y)
            blurRadius: 10.0,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: Column(
        children: [
          Container(
              width: 391,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: photo == null
                        ? (AssetImage(
                            'assets/images/adImage5.jfif',
                          ) as ImageProvider)
                        : MemoryImage(
                            base64Decode(photo),
                          ),
                    fit: BoxFit.cover),
              )),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 9),
                child: Text(
                  'صاحب الاعلان  : ',
                  style: TextStyle(color: Colors.blue, fontSize: 15.5),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                storename,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  color: Colors.red, // width: double.infinity,
                ),
                child: MaterialButton(
                  onPressed: () {
                    deleteAds(id);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "حذف الأعلان".tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.delete_sweep,
                        size: 30,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
          "جميع الاعلانات",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: fetchAllAds(),
    );
  }

  //Pub up Function2--------------------------------------------------------------------------------------------
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
          Text("تم حذف الأعلان")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminMainScreen()));
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}
