import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
class MoreScreen extends StatefulWidget
{
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(Icons.arrow_back, color: Colors.blue,size: 35,)),
        title: Text(
          "أكثر",
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
              color: Colors.grey,
              size: 30,

            ),

          ),

          IconButton(
            onPressed: () {
              onNotification;
            },
            icon: Icon(
              Icons.menu_book,
              color: Colors.grey,
              size: 30,

            ),

          ),
          IconButton(
            onPressed: () {
              onNotification;
            },
            icon: Icon(
              Icons.shopping_basket_sharp,
              color: Colors.blue,
              size: 30,

            ),

          ),
        ],
      ),

      body:

      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
          Column(
            children: [
              Container(
                child:Row(
                  children: [
                    CircleAvatar
                      (
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(width: 30,),
                    Text("Mohammad Halaweh",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)

                  ],

                ) ,
                height: 150.0,
                padding: EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
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
              SizedBox(height: 10,),
              Container(
                child:
                Column(
                  children: [
                    Row(children: [
                      Icon(Icons.widgets,color: Colors.blue,size: 30,),
                      SizedBox(width: 20,),
                      Text("تسوق حسب الفئة",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                      
                    ],),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.lock_clock,color: Colors.blue,size: 30,),
                      SizedBox(width: 20,),
                      Text("أحدث المنتجات",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                    ],),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.workspaces_outline,color: Colors.blue,size: 30,),
                      SizedBox(width: 20,),
                      Text("خصومات",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                    ],),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.widgets_outlined,color: Colors.blue,size: 30,),
                      SizedBox(width: 20,),
                      Text("منتجات مميزة",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                    ],),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.subdirectory_arrow_left,color: Colors.blue,size: 30,),
                      SizedBox(width: 20,),
                      Text("الاكثر رواجا",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                    ],),
                    SizedBox(height: 20,),
                    Row(children: [
                      Icon(Icons.wysiwyg,color: Colors.blue,size: 30,),
                      SizedBox(width: 20,),
                      Text("خصومات وعروض",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                    ],),
                    SizedBox(height: 20,),
                  
                ],) ,
                
                
                height: 325.0,
                padding: EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
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
          ],)

      ),








    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}




