import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/addProduct_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_account_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_products_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeper_profile_screen.dart';
import '../login/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ShopkeeperProductsEditScreen extends StatefulWidget
{
  @override
  State<ShopkeeperProductsEditScreen> createState() => _ShopkeeperProductsEditScreenState();
}

class _ShopkeeperProductsEditScreenState extends State<ShopkeeperProductsEditScreen> {

  File? _image;
  Future getImage() async
  {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null)return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary ;
    });
  }


  var formkey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(Icons.arrow_back, color: Colors.blue,size: 35,)),
        title: Text(
          "تعديل / حذف المنتج",
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
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Padding(
          padding: const EdgeInsets.all(20),
          child:
          Container(
            child: SingleChildScrollView(
              child:
              Form(
                key: formkey,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  صورة المنتج-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "صورة المنتج",
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
                              "قم بتعديل الصورة",
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
                    //  الاسم المنتج-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "اسم المنتج",
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

                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //  سعر المنتج-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "سعر المنتج",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextFormField(
                      onFieldSubmitted: (String value) {
                      },
                      onChanged: (String value) {
                      },
                      decoration: InputDecoration(

                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // وصف بسيط عن المنتج-----------------------------------------------------------------------------------------------------------------
                    Text(
                      "وصف بسيط عن المنتج",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextField(
                      // controller: descriptionController,
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

                    //تعديل / حذف -----------------------------------------------------------------------------------------------------------------
                    Row(
                      children:
                      [
                        //تعديل
                        Container(
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.blue, // width: double.infinity,
                          ),
                          child: MaterialButton(
                            onPressed: ()
                            {
                              showDialog(context: context,builder: (BuildContext context) =>_buildPopupDialog(context),);
                            },
                            child: Text(
                              "تعديل",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                        //حذف
                        Container(
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.red, // width: double.infinity,
                          ),
                          child: MaterialButton(
                            onPressed: ()
                            {
                              showDialog(context: context,builder: (BuildContext context) =>_buildPopupDialog2(context),);
                            },
                            child: Text(
                              "حذف المنتج",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  //Pub up Function1--------------------------------------------------------------------------------------------
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
          Text("تم تعديل المنتج بنجاح")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShopkeeperProductsScreen()));
          },
          textColor: Colors.blue,
          child: const Text('موافق'),
        ),
      ],
    );
  }
  //-----------------------------------------------------------------------------------------------------------

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
          Text("تم حذف المنتج بنجاح")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShopkeeperProductsScreen()));
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
