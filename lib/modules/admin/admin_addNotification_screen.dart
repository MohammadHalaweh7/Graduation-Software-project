import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import '../language/language_screen.dart';
import '../login/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'admin_account_screen.dart';
import 'admin_profile_screen.dart';
import 'admin_screen.dart';
import 'admin_shops_screen.dart';

class AddNotificationScreen extends StatefulWidget {
  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
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
            'name': 'Mohammad',
            'lastname': 'Halaweh',
            'status': 'done'
          },
          'to':
              "e3YH1bNXSEGLsMk4LV8ia4:APA91bEI6Cbyx9deSMJ0WLBNTRI8C4LviKkzBRNhlBgaVZhPAOswnjq4DNDnvt91L2D8gxc1UnYHeClUA6WOKsEctpqydkYubDPN4S5Tr8wr8eBgK2oG3lO7m0ast2uyXO6qgs9h_umG"

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
        await http.post(Uri.parse(fetchData.baseURL + "/admin/notifications"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + token.toString()
            },
            body: body);

    print(result.statusCode);

    if (result.statusCode == 201) {
      adminSendNotification();
      var body = jsonDecode(result.body);
      sendNotfiy(titleController.text, descriptionController.text);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminMainScreen()));
    }

    if (result.statusCode == 413) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog3(context),
      );
    }
  }

  Future<UserModel> adminSendNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/users/adminSendNotification"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    print(result.statusCode);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    return userModel;
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
          "ارسال تنبيه".tr,
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
                      "اضف صورة للاشعار".tr,
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
                              "اختر صورة من المعرض".tr,
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
                      "عنوان الاشعار".tr,
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
                      "وصف الاشعار".tr,
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
                          hintText: 'قم بوصف الاشعار'.tr,
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
                          "ارسال".tr,
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
          Text("تم ارسال اشعار للمستخدمين".tr)
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
          child: Text('موافق'.tr),
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
          Text("الرجاء ادخال جميع الحقول".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
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
          Text("حجم الصورة تجاوز الحد المسموح".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
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
