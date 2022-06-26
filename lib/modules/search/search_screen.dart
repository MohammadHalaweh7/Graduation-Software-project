import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
class SearchScreen extends StatefulWidget
{
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var formkey = GlobalKey<FormState>();

  bool isPassword=true;


  final items =['شوز','شنطة',"مكياج"];
  String? value;

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
          "بحث",
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
          Padding(
            padding:const EdgeInsets.all(20),
            child:
            Container(
              child: SingleChildScrollView(
                child:
                Form(
                  key:formkey,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:
                    [
                      SizedBox(height: 10,),
                      Text("اسم المنتج",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      SizedBox(height: 10,),
                      //الاسم
                      TextFormField(


                        onFieldSubmitted:(String value)
                        {
                          print(value);
                        },
                        onChanged:(String value)
                        {
                          print(value);
                        },
                        decoration: InputDecoration(

                          // hintText: "البريد الالكتروني",
                          labelText: "الاسم",

                          border:OutlineInputBorder(),


                        ),
                      ),
                      SizedBox(
                        height: 15 ,
                      ),
                      //الفئة
                      Text("الفئة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      Padding(
                        padding:const EdgeInsets.all(0),
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child:
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                              [
                                SizedBox(
                                  height: 0,
                                ),

                                Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>
                                      (
                                      icon: Icon(Icons.arrow_downward_rounded),
                                      isExpanded: true,
                                      value: value,
                                      items: items.map(buildMenuItem).toList(),
                                      onChanged:(value) => setState(() => this.value=value),
                                    ),
                                  ),
                                ),


                                SizedBox(
                                  height: 20,
                                ),


                              ],),
                          ),
                        ),
                      ),
                      //تصنيف فرعي
                      Text("تصنيف فرعي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      Padding(
                        padding:const EdgeInsets.all(0),
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child:
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                              [
                                SizedBox(
                                  height: 0,
                                ),

                                Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 2),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>
                                      (
                                      icon: Icon(Icons.arrow_downward_rounded),
                                      isExpanded: true,
                                      value: value,
                                      items: items.map(buildMenuItem).toList(),
                                      onChanged:(value) => setState(() => this.value=value),
                                    ),
                                  ),
                                ),


                                SizedBox(
                                  height: 20,
                                ),


                              ],),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 ,
                      ),
                      //السعر
                      Text("السعر",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        height: 65,
                        width: double.infinity,
                        child:
                        Row(
                          children: [
                            SizedBox(width: 10,),
                          Text("اقل سعر",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(width: 230,),
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                        ],),
                      ),
                      SizedBox(
                        height: 10 ,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        height: 65,
                        width: double.infinity,
                        child:
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("أعلى سعر",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(width: 220,),
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],),
                      ),
                      SizedBox(
                        height: 40 ,
                      ),










                      //بحث
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.blueAccent,                      // width: double.infinity,
                        ),

                        child: MaterialButton(

                          onPressed:(){
                            if(formkey.currentState!.validate())
                            {
                              print("[");
                              print("[");
                            }

                          },
                          child:
                          Text("بحث",style: TextStyle(color: Colors.white),),



                        ),
                      ),




                    ],),
                ),
              ),
            ),
          ),


      ),








    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }



  DropdownMenuItem<String> buildMenuItem(String item)=>
      DropdownMenuItem(value: item,
        child:
        Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15),
        )
        ,);
}




