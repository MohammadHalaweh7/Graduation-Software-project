import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/user/user_model.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_edit_password_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_screen.dart';
import 'package:udemy_flutter/modules/editPassword/editPassword.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';

import 'package:http/http.dart' as http;
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'admin_addNotification_screen.dart';
import 'admin_profile_screen.dart';
// baba

class AdminAccountScreen extends StatefulWidget {
  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen> {
  //هدول للصورة
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
  //----------------------------------------------------------------------------

  var formkey = GlobalKey<FormState>();
  String? value;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey2 = GlobalKey<FormState>();

  Future<UserModel> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var result = await http.get(
      Uri.parse(fetchData.baseURL + "/admin/me"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    print(result.statusCode);

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    nameController.text = userModel.name;
    emailController.text = userModel.email;

    return userModel;
  }

  Future<UserModel> editData() async {
    var token;
    var body;
    if (!(myImage == null)) {
      var bytes = await new File(myImage.path).readAsBytes();
      String base64 = base64Encode(bytes);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.get('token');
      body = jsonEncode({
        'email': emailController.text,
        'name': nameController.text,
        'avatar': base64
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.get('token');
      body = jsonEncode({
        'email': emailController.text,
        'name': nameController.text,
      });
    }

    var result =
        await http.patch(Uri.parse(fetchData.baseURL + "/admin/editInfo"),
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

    UserModel userModel = UserModel.fromJson(jsonDecode(result.body));

    nameController.text = userModel.name;
    emailController.text = userModel.email;

    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
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
                "حسابي".tr,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [],
            ),
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
            
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          //الصورة الشخصية
                          GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 52.0,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              _image!,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            )))
                                    : CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor: Colors.white,
                                        backgroundImage: account!.avatar == null
                                            ? (NetworkImage(
                                                'https://static.thenounproject.com/png/3322766-200.png',
                                              ) as ImageProvider)
                                            : MemoryImage(
                                                base64Decode(
                                                    account.avatar.toString()),
                                              ),
                                      ),
                                CircleAvatar(
                                  radius: 15.8,
                                  backgroundColor: Colors.blue,
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          //الاسم
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      height: 150.0,
                      padding: EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Form(
                            key: formkey2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "اسم المستخدم".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //الاسم
                                TextFormField(
                                  controller: nameController,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "الرجاء ادخال اسم المستخدم".tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                //----------------------------------------------------------------------------------------------------
                                //البريد الالكتروني
                                Text(
                                  "البريد الالكتروني".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //البريد الالكتروني
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "الرجاء ادخال البريد الالكتروني"
                                          .tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),

                                //تعديل
                                Container(
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
                                SizedBox(
                                  height: 15,
                                ),
                                //تغيير كلمة السر
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color:
                                        Colors.grey, // width: double.infinity,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminEditPasswordScreen()));
                                    },
                                    child: Text(
                                      "تغيير كلمة السر".tr,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      height: 550.0,
                      padding: EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
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
          Text("تم تعديل البيانات بنجاح".tr)
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
  //------------------------------------------------------------------------------------------------------------

  void onNotification() {
    Navigator.pop(context);
  }
}

class _id {}
