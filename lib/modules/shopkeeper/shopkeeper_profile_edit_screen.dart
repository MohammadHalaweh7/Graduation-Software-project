import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/API/sharedPrefs.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import '../login/login_screen.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ShopkeeperProfileEditScreen extends StatefulWidget {
  @override
  State<ShopkeeperProfileEditScreen> createState() => _ShopkeeperProfileEditScreenState();
}

class _ShopkeeperProfileEditScreenState extends State<ShopkeeperProfileEditScreen> {

  File? _image;

  Future getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null)return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary ;
    });


  }




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
    'للأطفال',
    'للسيدات',
    "للرجال",
    "اكسسوارات",
    "هدايا",
    "ماكولات",
    "ملابس",
    "أحذية",
    "عطور",
    'فنون'
  ];

  final citiesItems = [
    'القدس',
    'راماالله',
    "نابلس",
    "بيت لحم",
    "طولكرم",
    "قلقيلية",
    "الخليل",
    "سلفيت",
    "الداخل"
  ];

  String? value2;

  String? value3;


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
          "تعديل الملف الشخصي",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              onNotification;
            },
            icon: Icon(
              Icons.add_alert_outlined,
              color: Colors.black54,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 30),
                child: Image.asset(
                  'assets/images/logo3.png',
                  width: 150,
                ),
              ),
              Text(
                "متجراتي",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff758DFF)),
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
                  "الرئيسية",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("الى الرئيسية"),
                leading: Icon(Icons.store, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
                },
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
                  "معلومات المستخدم",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("حسابي"),
                leading: Icon(Icons.person, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperAccountScreen()));
                },
              ),
              ListTile(
                title: Text("متجري"),
                leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperProfileScreen()));
                },
              ),
              ListTile(
                title: Text("منتجاتي"),
                leading: Icon(Icons.production_quantity_limits, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopkeeperProductsScreen()));
                },
              ),
              ListTile(
                title: Text("اضافة منتج جديد"),
                leading: Icon(Icons.add_shopping_cart, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),
              ListTile(
                title: Text("حذف المتجر نهائيا"),
                leading: Icon(Icons.highlight_remove_sharp, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
              ),



              ListTile(
                title: Text("تسجيل خروج"),
                leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                onTap: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.remove('token');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
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
                padding: const EdgeInsets.only(left: 220),
                child: Text(
                  "التطبيق",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("اللغة"),
                leading: Icon(Icons.g_translate, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageScreen()));
                },
              ),

              ListTile(
                title: Text("عن متجراتي"),
                leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("ضبط"),
                leading: Icon(Icons.gamepad, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("سياسة الخصوصية"),
                leading: Icon(Icons.warning, color: Color(0xff758DFF)),
                onTap: () {},
              ),

            ],
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
                    //  صورة المتجر-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "صورة المتجر",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.blue, // width: double.infinity,
                          ),
                          child: MaterialButton(
                            onPressed: ()
                            {
                              getImage();
                            },
                            child: Text(
                              "تعديل الصورة",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                        _image !=null ? Image.file(_image!,width: 120,height: 120,fit: BoxFit.cover,): Image.network('https://static.thenounproject.com/png/3322766-200.png',width: 120,height: 120,),

                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // المتجر الاسم-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "اسم المتجر",
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
                      "وصف بسيط عن المتجر",
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
                      "الهاتف",
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
                          return "الرجاء ادخال رقم الهاتف";
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
                      "عنوان المتجر",
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
                      "الفئة المختارة",
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
                      "المدينة المختارة",
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
                      "رابط فيسبوك",
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
                      "رابط انستغرام",
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
                      "رابط سناب شات",
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
                      "رابط الخريطة",
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
                      "رقم واتس اب",
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
                    //تعديل-----------------------------------------------------------------------------------------------------------------
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blueAccent, // width: double.infinity,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          // pendingStoreSignUp(context);
                          showDialog(context: context,builder: (BuildContext context) => _buildPopupDialog(context),);
                        },
                        child: Text(
                          "تعديل",
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
          Text("تم تعديل الملف الشخصي بنجاح")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShopkeeperProfileScreen()));
            //  Navigator.of(context).pop();
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
