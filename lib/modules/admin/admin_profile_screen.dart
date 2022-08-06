import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/modules/admin/admin_profile_edit_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../layout/shop_layout/shop_layout.dart';
import '../../src/my_app.dart';



class AdminProfileScreen extends StatefulWidget {
  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  var defaultText = TextStyle(color: Colors.black);

  var linkText = TextStyle(color: Colors.black);

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
          "من نحن!".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              //الصورة
              Container(
                height: 340,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1.0), //(x,y)
                        blurRadius: 20.0,
                      ),
                    ],
                    color: Colors.white,
                    image: DecorationImage(
                        image: avatar == null
                            ? AssetImage(
                          'assets/images/logo3.png',
                        ) as ImageProvider
                            : MemoryImage(
                          base64Decode(avatar),
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.grey[300], // width: double.infinity,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminProfileEditScreen()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "تعديل المعلومات".tr,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.edit_sharp,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              //الشرح
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 670,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //من نحن
                    Center(
                      child: Text(
                        'من نحن !'.tr,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //الشرح
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        'اهلا بك في تطبيقنا التطبيق الأول من نوعه في فلسطين في مجال الاون لاين. حيث يضم مجموعة متميزة من المتاجر الفلسطينية في مختلف المجالات الجمال و الصحة و الالبسة و الالكترونيات و الاطعمة وغيرها الكثير والكثير'.tr,
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //عن متجراتي
                    Center(
                      child: Text(
                        'عن متجراتي !'.tr,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //الشرح
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        'كل ما يهمك تجده في تطبيقنا حيث ستجد باقة من المتاجر في تطبيق واحد. \n يتميز تطبيقنا بسهولة التسوق والبحث عن العروض والخصومات الخاصة بالمتاجر المفضلة لديك. يمكنك من خلال تصفح متاجرنا شراء ما تحتاجه بكبسه واحده يصلك طلبك إلى باب بيتك حيثما كنت في أنحاء فلسطين والدفع يتم عند استلامك لطلبك. \n هيا ماذا تنتظر سارع للانضمام إلى تطبيقنا وشاهد كل ما يحلو لك من المنتجات و البضائع والعروض والخصومات الهائلة والسرعه في الاستجابة. \n نسعى دومًا لمساعدتك في تحصيل العروض التي تبهرك!'.tr,
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //من نحن
                    Center(
                      child: Text(
                        'ما يميزنا !'.tr,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //  الشرح
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        '- خصومات وعروض لا تفوتك \n- يضم عروض العديد من المتاجر في مختلف المجالات \n- فئات متنوعة تناسب احتاجاتك \n- سهولة في الطلب وسرعة في التوصيل. \n- افضل العروض في كافة مناطق فلسطين'.tr,
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),


              //تواصل معنا
              Container(
                margin: EdgeInsets.symmetric(horizontal: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 7.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 67,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تواصل معنا".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),

                  ],
                ),
              ),
              //هاتف
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 67,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "هاتف".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '0598939763',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //فيسبوك
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 67,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "فيسبوك".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: 'https://www.facebook.com/Matjarati',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = facebook;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                    ),
                  ],
                ),
              ),

              //سناب شات
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 67,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "سناب شات".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: 'https://www.SnapShat.com/Matjarati',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = snapchat;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                    ),
                  ],
                ),
              ),

              //انستغرام
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 67,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.wysiwyg,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "انستغرام".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    Container(
                      width: 200,
                      child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                                style: linkText,
                                text: 'https://www.Instagram.com/Matjarati',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url = instagram;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw " cannot load url";
                                    }
                                  }),
                          ])),
                    ),
                  ],
                ),
              ),

              //واتس أب
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                // color: Colors.white,
                height: 67,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "واتس أب".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '+970598939763',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}
