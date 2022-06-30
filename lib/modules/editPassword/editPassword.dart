import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import "package:url_launcher/url_launcher.dart";
import '../../src/my_app.dart';
class EditPasswordScreen extends StatefulWidget
{
  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  var formkey = GlobalKey<FormState>();
  String? value;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
          "تغييري كلمة السر",
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
             
              SizedBox(height: 30,),
              Container(
                child:
                Column(
                  children:
                  [

                    Form(
                      key:formkey,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children:
                        [
                          //كلمة المرور
                          SizedBox(height: 10,),
                          Text("كلمة المرور",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          SizedBox(height: 10,),
                          //كلمة المرور
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
                                return"الرجاء ادخال كلمة المرور";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border:OutlineInputBorder(),
                              // labelText: 'كلمة السر'

                            ),
                          ),
                          SizedBox(
                            height: 15 ,
                          ),
                          //----------------------------------------------------------------------------------------------------
                          //تاكيد كلمة المرور
                          Text(" تاكيد كلمة المرور",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                          SizedBox(height: 10,),
                          // تاكيد كلمة المرور
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
                                return"الرجاء ادخال كلمة المرور";
                              }
                              return null;
                            },
                            decoration: InputDecoration(

                              border:OutlineInputBorder(),

                            ),
                          ),
                          SizedBox(
                            height: 70 ,
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
                                if(formkey.currentState!.validate())
                                {
                                  print("[");
                                  print("[");
                                }

                              },
                              child:
                              Text("تعديل",style: TextStyle(color: Colors.white),),

                            ),
                          ),
                          SizedBox(
                            height: 15 ,
                          ),



                        ],),
                    ),



                  ],) ,


                height: 500.0,
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen()));

  }
}




