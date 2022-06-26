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
class ProfileShoScreen extends StatefulWidget
{
  @override
  State<ProfileShoScreen> createState() => _ProfileShoScreenState();
}

class _ProfileShoScreenState extends State<ProfileShoScreen> {
  var defaultText = TextStyle(color: Colors.black);

  var linkText = TextStyle(color: Colors.black);

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
          "عن المتجر",
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
      drawer: Drawer(

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8,top: 30),
                child: Image.asset('assets/images/logo3.png',width: 150,),
              ),
              Text("متجراتي",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Color(0xff758DFF)),),
              SizedBox(height: 20,),
              Container(width: 300,height: 1,color: Colors.grey[300],),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Text("الرئيسية",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Color(0xff758DFF)),),
              ),
              ListTile(
                title: Text("الى المتاجر"),

                leading: Icon(Icons.store,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              SizedBox(height: 0,),
              Container(width: 300,height: 1,color: Colors.grey[300],),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 147),
                child: Text("معلومات المستخدم",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Color(0xff758DFF)),),
              ),
              ListTile(
                title: Text("حسابي"),
                leading: Icon(Icons.person,color:Color(0xff758DFF)),
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                } ,
              ),
              ListTile(
                title: Text("منتجات أعجبتني"),
                leading: Icon(Icons.favorite,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              ListTile(
                title: Text("منتجات طلبتها"),
                leading: Icon(Icons.add_chart,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              ListTile(
                title: Text("منتجات شاهدتها"),
                leading: Icon(Icons.remove_red_eye_outlined,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              ListTile(
                title: Text("تسجيل خروج"),
                leading: Icon(Icons.logout,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              SizedBox(height: 0,),
              Container(width: 300,height: 1,color: Colors.grey[300],),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Text("التطبيق",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Color(0xff758DFF)),),
              ),
              ListTile(
                title: Text("اللغة"),
                leading: Icon(Icons.g_translate,color:Color(0xff758DFF)),
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LanguageScreen()));

                } ,
              ),
              ListTile(
                title: Text("للانضمام الى متجراتي"),
                leading: Icon(Icons.person_add,color:Color(0xff758DFF)),
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => JoinAppScreen()));

                } ,
              ),
              ListTile(
                title: Text("عن متجراتي"),
                leading: Icon(Icons.assignment,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              ListTile(
                title: Text("ضبط"),
                leading: Icon(Icons.gamepad ,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              ListTile(
                title: Text("سياسة الخصوصية"),
                leading: Icon(Icons.warning,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),
              ListTile(
                title: Text("قيم هذا التطبيق"),
                leading: Icon(Icons.star,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),

            ],
          ),
        ),
      ),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Container
          (
          width: double.infinity ,
          child:
          Column
            (
            children:
            [
              //الصورة
              Container(
                height: 390,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/daffodil.png',),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(30)
                ),
              ),

              //دافوديل
              SizedBox(height: 0,),
              Container(
                color: Colors.white,

                height: 180,
                width: double.infinity,
                 padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("دافوديل | Daffodil",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text("لكي تكوني متميزة بارقى واحدث موديلات ملابس الصبايا . تفضلي بزيارة محلنا عنوان المحل نابلس - شارع كلية الروضة - بجانب مدرسة جردانة وسوق القهوة",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                ),
                    SizedBox(height: 10,),




                  ],
                ),

              ),

              //هاتف
              SizedBox(height: 10,),
              Container(
                color: Colors.white,

                height: 150,

                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("هاتف",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("00970599312665",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),




                  ],
                ),

              ),

              //زيارة موقعنا
              SizedBox(height: 10,),
              Container(
                color: Colors.white,
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place_outlined,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("زيارة موقعنا",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text("لكي تكوني متميزة بارقى واحدث موديلات ملابس الصبايا . تفضلي بزيارة محلنا عنوان المحل نابلس - شارع كلية الروضة - بجانب مدرسة جردانة وسوق القهوة",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),




                  ],
                ),

              ),
              //فيسبوك
              SizedBox(height: 10,),
              Container(
                color: Colors.white,

                height: 150,

                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.facebook,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("فيسبوك",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    RichText(
                        text:
                        TextSpan(
                            children: [
                              TextSpan(
                                  style: linkText,
                                  text: "www.facebook.com/DaffodilWomenFashion",
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    var url = "https://www.facebook.com/DaffodilWomenFashion";
                                    if(await canLaunch(url)){
                                      await launch(url);
                                    }
                                    else
                                    {
                                      throw " cannot load url";
                                    }
                                  }
                              ),
                            ]
                        )
                    ),



                  ],
                ),

              ),

              //سناب شات
              SizedBox(height: 10,),
              Container(
                color: Colors.white,

                height: 150,

                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.chat,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("سناب شات",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    RichText(
                        text:
                        TextSpan(
                            children: [
                              TextSpan(
                                  style: linkText,
                                  text: "www.snapchat.com/DaffodilWomenFashion",
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    var url = "https://www.snapchat.com/DaffodilWomenFashion";
                                    if(await canLaunch(url)){
                                      await launch(url);
                                    }
                                    else
                                    {
                                      throw " cannot load url";
                                    }
                                  }
                              ),
                            ]
                        )
                    ),



                  ],
                ),

              ),

              //واتس أب
              SizedBox(height: 10,),
              Container(
                color: Colors.white,

                height: 150,

                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("واتس أب",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("00970599312665",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),




                  ],
                ),

              ),

              //انستغرام
              SizedBox(height: 10,),
              Container(
                color: Colors.white,

                height: 150,

                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.wysiwyg,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("انستغرام",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    RichText(
                        text:
                        TextSpan(
                            children: [
                              TextSpan(
                                  style: linkText,
                                  text: "www.instagram.com/DaffodilWomenFashion",
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    var url = "https://www.instagram.com/DaffodilWomenFashion";
                                    if(await canLaunch(url)){
                                      await launch(url);
                                    }
                                    else
                                    {
                                      throw " cannot load url";
                                    }
                                  }
                              ),
                            ]
                        )
                    ),



                  ],
                ),

              ),


              //عنوان المتجر
              SizedBox(height: 10,),
              Container(
                color: Colors.white,

                height: 230,

                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.place_rounded,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text("عنوان المتجر",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,),),

                      ],
                    ),
                    SizedBox(height: 10,),
                    RichText(
                        text:
                        TextSpan(
                            children: [
                              TextSpan(
                                  style: linkText,
                                  text: "https://www.google.com/maps/place/66MQ%2BVVQ+%D9%85%D8%BA%D8%B3%D9%84%D8%A9+%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AC%D9%8A%D9%86%D8%8C+%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AC%D9%8A%D9%86%D8%8C+Nablus%E2%80%AD/@32.2347064,35.2397217,17z/data=!4m2!3m1!1s0x151ce1e7a2a5a571:0x47104ef833c63381?hl=en",
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    var url = "https://www.google.com/maps/place/66MQ%2BVVQ+%D9%85%D8%BA%D8%B3%D9%84%D8%A9+%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AC%D9%8A%D9%86%D8%8C+%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AC%D9%8A%D9%86%D8%8C+Nablus%E2%80%AD/@32.2347064,35.2397217,17z/data=!4m2!3m1!1s0x151ce1e7a2a5a571:0x47104ef833c63381?hl=en";
                                    if(await canLaunch(url)){
                                      await launch(url);
                                    }
                                    else
                                    {
                                      throw " cannot load url";
                                    }
                                  }
                              ),
                            ]
                        )
                    ),



                  ],
                ),

              ),

            ],
          ),
        ),
      ),








    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
