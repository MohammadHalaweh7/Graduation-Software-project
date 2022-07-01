import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/editPassword/editPassword.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
class AccountScreen extends StatefulWidget
{
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var formkey = GlobalKey<FormState>();
  String? value;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(Icons.menu, color: Colors.blue,size: 35,)),
        title: Text(
          "حسابي",
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
                  children:
                  [
                    //الصورة الشخصية
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      },
                      child: Stack(

                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 15.8,
                            backgroundColor: Colors.blue,


                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,


                          ),

                          Icon(Icons.edit,size: 30,color: Colors.grey,),
                        ],
                      ),
                    ),
                    SizedBox(width: 30,),
                    //الاسم
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
              SizedBox(height: 30,),
              Container(
                child:
                Column(
                  children:
                  [

                    Form(
                      key:formkey2,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children:
                        [

                          SizedBox(height: 10,),
                          Text("اسم المستخدم",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
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
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return"الرجاء ادخال اسم المستخدم";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                            border:OutlineInputBorder(),

                            ),
                          ),
                          SizedBox(
                            height: 15 ,
                          ),
                          //----------------------------------------------------------------------------------------------------
                          //البريد الالكتروني
                          Text("البريد الالكتروني",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          SizedBox(height: 10,),
                          //البريد الالكتروني
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,

                            onFieldSubmitted:(String value)
                            {
                              print(value);
                            },
                            onChanged:(String value)
                            {
                              print(value);
                            },
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return"الرجاء ادخال البريد الالكتروني";
                              }
                              return null;
                            },
                            decoration: InputDecoration(

                              prefixIcon: Icon(Icons.email),
                              border:OutlineInputBorder(),

                            ),
                          ),
                          SizedBox(
                            height: 80 ,
                          ),




                          //تعديل
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blueAccent,                      // width: double.infinity,
                            ),

                            child: MaterialButton(

                              onPressed:(){
                                if(formkey2.currentState!.validate())
                                {
                                  print(emailController.text);
                                  print(passwordController.text);
                                }

                              },
                              child:
                              Text("تعديل",style: TextStyle(color: Colors.white),),



                            ),
                          ),
                          SizedBox(
                            height: 15 ,
                          ),
                          //تغيير كلمة السر
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.grey,                      // width: double.infinity,
                            ),

                            child: MaterialButton(

                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordScreen()));


                              },
                              child:
                              Text("تغيير كلمة السر",style: TextStyle(color: Colors.white),),



                            ),
                          ),




                        ],),
                    ),



                  ],) ,


                height: 550.0,
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




