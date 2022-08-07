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
import '../home/main_screen.dart';
import '../login/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';

class ShopkeeperAddNotificationScreen extends StatefulWidget {
  @override
  State<ShopkeeperAddNotificationScreen> createState() =>
      _ShopkeeperAddNotificationScreenState();
}

class _ShopkeeperAddNotificationScreenState
    extends State<ShopkeeperAddNotificationScreen> {
  var serverToken =
      'AAAA1-uKg5g:APA91bGbOCRD5CsqtzDADIVk35DlYMVKMwK-VqcJ7bAbXassPWok45rFdRkWH7kk2TYo_ogERYfUUTkBsHwcBuBsBy4evMbmniLQr7TRlK4XpA_glaqvUivQdl9wWrUpeZjceIRCIz4k';

  sendNotfiy(String title, String body) async {
    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            //'id': id.toString(),
            'name': 'hamzeh',
            'lastname': 'saleh',
            'status': 'done'
          },
          'to':
              "fPsPXkmRS2ewPnoy5RhlVk:APA91bFvdQ6BY91xR7AmghEBWr7Uw_xvjx-IgI-7LL-Iwbze9OWRca0m9lHTS0LoLA498psJOJZXGgZnbHU7RGQ4vYW3_pzsz1mIC7qsADf1LRwpCjTHGhpbpVPK7fMrdufI3aHvnDWv"
          // "e3YH1bNXSEGLsMk4LV8ia4:APA91bEI6Cbyx9deSMJ0WLBNTRI8C4LviKkzBRNhlBgaVZhPAOswnjq4DNDnvt91L2D8gxc1UnYHeClUA6WOKsEctpqydkYubDPN4S5Tr8wr8eBgK2oG3lO7m0ast2uyXO6qgs9h_umG"

          //await FirebaseMessaging.instance.getToken()
        },
      ),
    );
  }

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

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  Future<void> createNotification(BuildContext context) async {
    if (titleController.text == '' || descriptionController.text == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog2(context),
      );
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var body;
    if (!(myImage == null)) {
      var bytes = await new File(myImage.path).readAsBytes();
      String base64 = base64Encode(bytes);
      body = jsonEncode({
        'title': titleController.text,
        'description': descriptionController.text,
        'avatar': base64,
      });
    } else {
      body = jsonEncode({
        'title': titleController.text,
        'description': descriptionController.text,
      });
    }

    var result =
        await http.post(Uri.parse(fetchData.baseURL + "/notifications"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + token.toString()
            },
            body: body);

    print(result.statusCode);

    if (result.statusCode == 201) {
      var body = jsonDecode(result.body);
      sendNotfiy(titleController.text, descriptionController.text);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
    }

    if (result.statusCode == 413) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog3(context),
      );
    }
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
                      controller: titleController,
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
                          createNotification(context);
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
                    builder: (context) => ShopKeeperMainScreen()));
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
          Text("الرجاء ادخال جميع الحقول ")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'),
        ),
      ],
    );
  }

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
          Text("حجم الصورة تجاوز الحد المسموح")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

  void onNotification() {
    Navigator.pop(context);
  }
}
