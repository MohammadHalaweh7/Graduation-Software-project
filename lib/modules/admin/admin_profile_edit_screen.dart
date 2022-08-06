import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/API/sharedPrefs.dart';
import 'package:udemy_flutter/models/aboutus/aboutus_model.dart';
import 'package:udemy_flutter/models/store/store_model.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import '../../layout/shop_layout/shop_layout.dart';
import '../login/login_screen.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'admin_profile_screen.dart';

class AdminProfileEditScreen extends StatefulWidget {
  @override
  State<AdminProfileEditScreen> createState() => _AdminProfileEditScreenState();
}

class _AdminProfileEditScreenState extends State<AdminProfileEditScreen> {
  //for image
  File? _image;
  var myImage;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    myImage = image;

    setState(() {
      this._image = imageTemporary;
    });
  }

  var formkey = GlobalKey<FormState>();

  var aboutUscontroller = TextEditingController();
  var aboutStorecontroller = TextEditingController();
  var specialcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var facebookcontroller = TextEditingController();
  var snapChatcontroller = TextEditingController();
  var instagramcontroller = TextEditingController();
  var whatsappcontroller = TextEditingController();

  Future<AboutUsModel> loadData() async {
    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/aboutUs/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(result.statusCode);

    AboutUsModel aboutusModel = AboutUsModel.fromJson(jsonDecode(result.body));

    aboutUscontroller.text = aboutusModel.aboutUsDescription;
    aboutStorecontroller.text = aboutusModel.aboutStoreDescription;
    specialcontroller.text = aboutusModel.makeUsSpecial;
    phonecontroller.text = aboutusModel.phoneNumber;
    facebookcontroller.text = aboutusModel.facebook;
    snapChatcontroller.text = aboutusModel.snapChat;
    instagramcontroller.text = aboutusModel.instagram;
    whatsappcontroller.text = aboutusModel.whatsapp;

    return aboutusModel;
  }

  Future<AboutUsModel> editData() async {
    var token;
    var body;
    if (!(myImage == null)) {
      var bytes = await new File(myImage.path).readAsBytes();
      String base64 = base64Encode(bytes);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.get('token');
      body = jsonEncode({
        'aboutUsDescription': aboutUscontroller.text,
        'aboutStoreDescription': aboutStorecontroller.text,
        'makeUsSpecial': specialcontroller.text,
        'phoneNumber': phonecontroller.text,
        'facebook': facebookcontroller.text,
        'snapChat': snapChatcontroller.text,
        'instagram': instagramcontroller.text,
        'whatsapp': whatsappcontroller.text,
        'avatar': base64
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.get('token');
      body = jsonEncode({
        'aboutUsDescription': aboutUscontroller.text,
        'aboutStoreDescription': aboutStorecontroller.text,
        'makeUsSpecial': specialcontroller.text,
        'phoneNumber': phonecontroller.text,
        'facebook': facebookcontroller.text,
        'snapChat': snapChatcontroller.text,
        'instagram': instagramcontroller.text,
        'whatsapp': whatsappcontroller.text,
      });
    }

    var result =
        await http.patch(Uri.parse(fetchData.baseURL + "/aboutUs/editInfo"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + token.toString()
            },
            body: body);

    print(result.statusCode);

    if (result.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }

    AboutUsModel aboutus = AboutUsModel.fromJson(jsonDecode(result.body));

    return aboutus;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AboutUsModel>(
      future: loadData(),
      builder: (context, snapshot) {
        var account = snapshot.data;
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
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
                  "تعديل صفحة التعريف".tr,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  تعديل الصورة-----------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 220,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: Colors
                                          .blue, // width: double.infinity,
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      child: Text(
                                        "تعديل الصورة".tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  _image != null
                                      ? Image.file(
                                          _image!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          'https://static.thenounproject.com/png/3322766-200.png',
                                          width: 120,
                                          height: 120,
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //من نحن.....عن متجراتي.....ما يميزنا
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1.0), //(x,y)
                                    blurRadius: 20.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  // من نحن-----------------------------------------------------------------------------------------------------------------
                                  Center(
                                    child: Text(
                                      "من نحن !".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  TextField(
                                    controller: aboutUscontroller,
                                    minLines: 5,
                                    maxLines: 20,
                                    onTap: () {},
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        helperStyle:
                                            TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // عن متجراتي-----------------------------------------------------------------------------------------------------------------
                                  Center(
                                    child: Text(
                                      "عن متجراتي !".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  TextField(
                                    controller: aboutStorecontroller,
                                    minLines: 10,
                                    maxLines: 20,
                                    onTap: () {},
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        helperStyle:
                                            TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // ما يميزنا-----------------------------------------------------------------------------------------------------------------
                                  Center(
                                    child: Text(
                                      "ما يميزنا !".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  TextField(
                                    controller: specialcontroller,
                                    minLines: 5,
                                    maxLines: 20,
                                    onTap: () {},
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      helperStyle:
                                          TextStyle(color: Colors.white70),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      // labelText: "ادخل اسم متجرك هنا",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //الهاتف---------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "الهاتف".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: phonecontroller,
                                keyboardType: TextInputType.phone,
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
                              height: 15,
                            ),
                            //رابط فيسبوك--------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "رابط فيسبوك".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: facebookcontroller,
                                onFieldSubmitted: (String value) {},
                                onChanged: (String value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //رابط انستغرام--------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "رابط انستغرام".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: instagramcontroller,
                                onFieldSubmitted: (String value) {},
                                onChanged: (String value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //رابط سناب شات--------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "رابط سناب شات".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: snapChatcontroller,
                                onFieldSubmitted: (String value) {},
                                onChanged: (String value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //رقم واتس اب--------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "رقم واتس اب".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: whatsappcontroller,
                                keyboardType: TextInputType.phone,
                                onFieldSubmitted: (String value) {},
                                onChanged: (String value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //تعديل-----------------------------------------------------------------------------------------------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors
                                      .blueAccent, // width: double.infinity,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    editData();
                                  },
                                  child: Text(
                                    "تعديل".tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
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
          Text("تم تعديل الملف الشخصي بنجاح".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminProfileScreen()));
            //  Navigator.of(context).pop();
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
