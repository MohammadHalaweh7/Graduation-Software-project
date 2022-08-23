import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../language/language_screen.dart';
import '../login/login_screen.dart';
import 'admin_account_screen.dart';
import 'admin_addNotification_screen.dart';
import 'admin_profile_screen.dart';
import 'admin_screen.dart';
import 'admin_shops_screen.dart';

var email;
var storeName;

class AdminAddPosterScreen extends StatefulWidget {
  SetEmail(E) {
    email = E;
  }

  SetStoreName(N) {
    storeName = N;
  }

  @override
  State<AdminAddPosterScreen> createState() => _AdminAddPosterScreenState();
}

class _AdminAddPosterScreenState extends State<AdminAddPosterScreen> {
  File? _image;
  var myImage;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    myImage = image;

    setState(() {
      this._image = imageTemporary;
      //print(image.path);
    });
  }

  Future<void> CreateAD() async {
    var token;
    var body;
    if (!(myImage == null)) {
      var bytes = await new File(myImage.path).readAsBytes();
      String base64 = base64Encode(bytes);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.get('token');
      // print(token);
      body =
          jsonEncode({'photo': base64, 'email': email, 'storename': storeName});
    }

    var result = await http.post(Uri.parse(fetchData.baseURL + '/admin/photos'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token.toString()
        },
        body: body);

    print(result.statusCode);

    if (result.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  drawer: Drawer(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 30),
                  child: Image.asset(
                    'assets/images/logo3.png',
                    width: 180,
                  ),
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
                        "الرئيسية".tr,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("الى الرئيسية".tr),
                      leading: Icon(Icons.store, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminMainScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("الى المتاجر".tr),
                      leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminShopsScreen()));
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
                      padding: const EdgeInsets.only(left: 147),
                      child: Text(
                        "معلومات المستخدم".tr,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("حسابي".tr),
                      leading: Icon(Icons.person, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminAccountScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("طلبات المتاجر الجديدة".tr),
                      leading: Icon(Icons.remove_from_queue_outlined,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("ارسال اشعارات".tr),
                      leading: Icon(Icons.notification_add,
                          color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNotificationScreen()));
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
                      padding: const EdgeInsets.only(left: 200),
                      child: Text(
                        "التطبيق".tr,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff758DFF)),
                      ),
                    ),
                    ListTile(
                      title: Text("اللغة".tr),
                      leading:
                          Icon(Icons.g_translate, color: Color(0xff758DFF)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("عن محلات PS".tr),
                      leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                      onTap: () {
                            Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminProfileScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("تسجيل خروج".tr),
                      leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('token');
                        prefs.remove('type');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            
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
          "انشاء اعلان",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  "قم بانشاء اعلانك" -----------------------------------------------------------------------------------------------------------------
                  Center(
                    child: Image.asset(
                      'assets/images/ad3.gif',
                      width: 150,
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      height: 40,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.blue, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "أضف اعلانك",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(
                              Icons.add_photo_alternate,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1.0), //(x,y)
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Container(
                        width: 391,
                        height: 200,
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://static.thenounproject.com/png/3322766-200.png',
                                width: 391,
                                height: 200,
                              ),
                      )),

                  SizedBox(
                    height: 50,
                  ),

                  //ارسال الطلب-----------------------------------------------------------------------------------------------------------------
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.blue, // width: double.infinity,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (!(myImage == null)) {
                          CreateAD();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog2(context),
                          );
                        }
                      },
                      child: Text(
                        "انشاء الاعلان",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
          Text("تم انشاء الاعلان بنجاح")
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
          Text('الرجاء ادخال الصورة ثم اضغط على انشاء الاعلان')
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
