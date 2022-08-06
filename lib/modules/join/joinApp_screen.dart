import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/API/sharedPrefs.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import '../login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class JoinAppScreen extends StatefulWidget {
  @override
  State<JoinAppScreen> createState() => _JoinAppScreenState();
}

class _JoinAppScreenState extends State<JoinAppScreen> {
  //for Image-------------------------------------------------------------------
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

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var phoneController = TextEditingController();
  var detailedLocationController = TextEditingController();
  var facebookController = TextEditingController();
  var instagramController = TextEditingController();
  var snapchatController = TextEditingController();
  var locationOnMapController = TextEditingController();
  var whatsappController = TextEditingController();
  var type;
  var city;

  bool isPassword = true;

  final categoriesItems = [
    'للأطفال'.tr,
    'للسيدات'.tr,
    "للرجال".tr,
    "اكسسوارات".tr,
    "انارة".tr,
    "ماكولات".tr,
    "ملابس".tr,
    "أحذية".tr,
    "عطور".tr,
    'الكترونيك'.tr
  ];

  final citiesItems = [
    'القدس'.tr,
    'راماالله'.tr,
    "نابلس".tr,
    "بيت لحم".tr,
    "طولكرم".tr,
    "قلقيلية".tr,
    "الخليل".tr,
    "سلفيت".tr,
    "الداخل".tr
  ];

  String? value2;

  String? value3;

  Future<void> pendingStoreSignUp(BuildContext context) async {
    var body;
    if (emailController.text == '' ||
        passwordController.text == '' ||
        nameController.text == '' ||
        descriptionController.text == '' ||
        phoneController.text == '' ||
        detailedLocationController.text == '' ||
        type == null ||
        city == null ||
        locationOnMapController.text == '' ||
        whatsappController.text == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog2(context),
      );
    }
    if (!(myImage == null)) {
      var bytes = await new File(myImage.path).readAsBytes();
      String base64 = base64Encode(bytes);
      body = jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'description': descriptionController.text,
        'phoneNumber': phoneController.text,
        'detailedLocation': detailedLocationController.text,
        'facebook': facebookController.text,
        'snapchat': snapchatController.text,
        'whatsapp': whatsappController.text,
        'instagram': instagramController.text,
        'locationOnMap': locationOnMapController.text,
        'location': city,
        'type': type,
        'avatar': base64
      });
    } else {
      body = jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'description': descriptionController.text,
        'phoneNumber': phoneController.text,
        'detailedLocation': detailedLocationController.text,
        'facebook': facebookController.text,
        'snapchat': snapchatController.text,
        'whatsapp': whatsappController.text,
        'instagram': instagramController.text,
        'locationOnMap': locationOnMapController.text,
        'location': city,
        'type': type,
      });
    }

    var result = await http.post(Uri.parse(fetchData.baseURL + "/pendingStore"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);

    print(result.statusCode);

    if (result.statusCode == 201) {
      var body = jsonDecode(result.body);
      // sharedPrefs.saveToken(body['token']);
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
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
          "انشاء متجر".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                    //الصورة------------------------------------------------------------------------------------------------------
                    Center(
                        child: Image.asset(
                      'assets/images/joinUs.gif',
                      width: 330,
                    )),
                    SizedBox(
                      height: 10,
                    ),

                    //  صورة المتجر-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "صورة المتجر".tr,
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    'https://static.thenounproject.com/png/3322766-200.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    //البريد الالكتروني------------------------------------------------------------------------------------------------------
                    Text(
                      "* البريد الالكتروني".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
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
                          return "الرجاء ادخال البريد الالكتروني".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //كلمة السر------------------------------------------------------------------------------------------------------
                    Text(
                      " * كلمة السر".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال كلمة السر".tr;
                        }
                        return null;
                      },
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            icon: isPassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // المتجر الاسم-----------------------------------------------------------------------------------------------------------------
                    Text(
                      " * اسم المتجر".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: nameController,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        // hintText: "البريد الالكتروني",
                        // labelText: "ادخل اسم متجرك هنا",

                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // وصف بسيط عن المتجر-----------------------------------------------------------------------------------------------------------------
                    Text(
                      " * وصف بسيط عن المتجر".tr,
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
                          // labelText: 'ادخل معلومات متجرك وسنتواصل معك قريبا',
                          hintText: 'قم بوصف متجرك '.tr,
                          helperStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //الهاتف---------------------------------------------------------------------------------------------------------------
                    Text(
                      " * الهاتف",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرجاء ادخال رقم الهاتف".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //عنوان المتجر -----------------------------------------------------------------------------------------------------------------
                    Text(
                      "* عنوان المتجر".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: detailedLocationController,
                      onFieldSubmitted: (String value) {},
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //الفئة--------------------------------------------------------------------------------------------------------------
                    Text(
                      " * اختر الفئة".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    onTap: () {},
                                    icon: Icon(Icons.arrow_downward_rounded),
                                    isExpanded: true,
                                    value: value2,
                                    items: categoriesItems
                                        .map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) => setState(() =>
                                        {this.value2 = value, type = value}),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //المدينة--------------------------------------------------------------------------------------------------------------
                    Text(
                      " * اختر المدينة".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(6)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    onTap: () {},
                                    icon: Icon(Icons.arrow_downward_rounded),
                                    isExpanded: true,
                                    value: value3,
                                    items:
                                        citiesItems.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() =>
                                        {this.value3 = value, city = value}),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //رابط فيسبوك--------------------------------------------------------------------------------------------------------------
                    Text(
                      "رابط فيسبوك".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: facebookController,
                      onFieldSubmitted: (String value) {},
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //رابط انستغرام--------------------------------------------------------------------------------------------------------------
                    Text(
                      "رابط انستغرام".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: instagramController,
                      onFieldSubmitted: (String value) {},
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //رابط سناب شات--------------------------------------------------------------------------------------------------------------
                    Text(
                      "رابط سناب شات".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: snapchatController,
                      onFieldSubmitted: (String value) {},
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //رابط الخريطة--------------------------------------------------------------------------------------------------------------
                    Text(
                      " * رابط الخريطة".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: locationOnMapController,
                      onFieldSubmitted: (String value) {},
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //رقم واتس اب--------------------------------------------------------------------------------------------------------------
                    Text(
                      " * رقم واتس اب".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      controller: whatsappController,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (String value) {},
                      onChanged: (String value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //انشاء-----------------------------------------------------------------------------------------------------------------
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blueAccent, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          pendingStoreSignUp(context);
                        },
                        child: Text(
                          "انشاء".tr,
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

  //هاد الفنكشن لخيارات الفئة---------------------------------------------------------------------------------
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
  //--------------------------------------------------------------------------------------------------

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
          Text("سوف تصلك رسالة قريبا بان تم قبول متجرك ام لا ".tr)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            //  Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

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
          Text("حجم الصورة تجاوز الحد المسموح")
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

  void onNotification() {
    Navigator.pop(context);
  }
}
