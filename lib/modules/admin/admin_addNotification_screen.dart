import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import '../login/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddNotificationScreen extends StatefulWidget {
  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {


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

  var formkey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();



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
          "ارسال تنبيه",
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
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  صورة المنتج-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "اضف صورة للاشعار",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.blue, // width: double.infinity,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              getImage();
                            },
                            child: Text(
                              "اختر صورة من المعرض",
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

                    SizedBox(
                      height: 15,
                    ),
                    //  عنوان الاشعار-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "عنوان الاشعار",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      // controller: nameController,
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
                    SizedBox(
                      height: 15,
                    ),

                    // وصف الاشعار-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "وصف الاشعار",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextField(
                      controller: descriptionController,
                      minLines: 5,
                      maxLines: 5,
                      onTap: () {},
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: 'قم بوصف الاشعار ',
                          helperStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //اضافة-----------------------------------------------------------------------------------------------------------------
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blue, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {

                          showDialog(context: context,builder: (BuildContext context) => _buildPopupDialog(context),);

                        },
                        child: Text(
                          "ارسال",
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
          Text("تم ارسال اشعار للمستخدمين")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminMainScreen()));
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  void onNotification() {
    print("mama");
  }
}
