import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/shops/shops_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
//Haytham Saleh
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap:(){
            var ScaffoldKey;
            //ScaffoldKey.currentState?.openDrawer();
            //        Navigator.push(context,MaterialPageRoute(builder: (context) => openDrawer()));

          },
          child: IconButton(
              onPressed: onNotification,
              icon: Icon(Icons.menu, color: Colors.blue,size: 35,)),
        ),
        title: Text(
          "الصفحة الرئيسية",
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
                  Navigator.push(context,MaterialPageRoute(builder: (context) => AccountScreen()));
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
        child: Column(
          children: [
            //تسوق حسب الفئة------------------------------------------------------
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 5,
                  height: 40,
                  color: Colors.blue,
                ),
                SizedBox(width: 7,),
                Text("تسوق حسب الفئة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(width: 170,),
                TextButton(
                  onPressed:()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, child:
                Text("عرض الكل"),


                ),
              ],),
            ),
            //List of type--------------------------------------------------------
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      child: Column(children: [

                        GestureDetector(
                          onTap:(){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => ShopsScreen()));

                          },
                          child: CircleAvatar(

                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/baby.jpg'),
                          ),
                        ),

                        SizedBox(height: 4,),
                        Text("للأطفال",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/women.png'),
                        ),
                        SizedBox(height: 4,),
                        Text("للسيدات",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/man.jpg'),

                        ),
                        SizedBox(height: 4,),
                        Text("للرجال",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/Accessories.jpg'),

                        ),
                        SizedBox(height: 4,),
                        Text("اكسسوارات",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/gifts.jpg'),

                        ),
                        SizedBox(height: 4,),
                        Text("هدايا",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/food.jpg'),

                        ),
                        SizedBox(height: 4,),
                        Text("ماكولات",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/clothes.jpg'),

                        ),
                        SizedBox(height: 4,),
                        Text("ملابس",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/shoes.png'),

                        ),
                        SizedBox(height: 4,),
                        Text("أحذية",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/perfumes.png'),

                        ),
                        SizedBox(height: 4,),
                        Text("عطور",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                    Container(
                      width: 90,
                      child: Column(children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35.0,
                          backgroundImage:AssetImage('assets/images/art.png'),

                        ),
                        SizedBox(height: 4,),
                        Text("فنون",maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ],),
                    ),
                    SizedBox(width: 0,),
                  ],
                ),
              ),
            ),
            //متاجراخترناها لك------------------------------------------------------
            Container(
              margin: EdgeInsets.only(top: 0),

              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 5,
                  height: 40,
                  color: Colors.blue,
                ),
                SizedBox(width: 7,),
                Text("متاجراخترناها لك",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(width: 180,),
                TextButton(
                  onPressed:()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, child:
                Text("عرض الكل"),


                ),
              ],),
            ),
            //متاجر------------------------------------------------------
            Container(
              margin: EdgeInsets.only(top: 20),
              height:310,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                        Image.asset('assets/images/daffodil.png',width: 200,height: 200,),
                        SizedBox(height: 10,),
                        Text("Daffodil | دافوديل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(right: 29.0),
                          child: Text("متجر الكتروني مختص ببيع ارقى واجمل ملابس الصبايا,تفضلي بزيارة متجرنا لكي تكوني الاجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        )

                      ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/enara.png',width: 200,height: 200,),
                          SizedBox(height: 10,),
                          Text("تنويرات الشروق",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع جميع لوازم النارة في المنزل , لكي تجعل منزلك اكثر رقي تفضل بزيارة متجرنا",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/drift.jpg',width: 205,height: 209,),
                          SizedBox(height: 10,),
                          Text("Drift For Men",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع ارقى واجمل الأحذية الرجالية الاصلية ,تفضل بزيارة متجرنا واحصل على اجمل الاحذية",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/rawafed.jpg',width: 400,height: 200,),
                          SizedBox(height: 10,),
                          Text("الروافد للادوات المنزلية",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع جميع الادوات المنزلية,تفضل بزيارة متجرنا لكي تجعل بيتك اجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/baby.jpg',width: 270,height: 207,),
                          SizedBox(height: 10,),
                          Text("Baby",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع ارقى واجمل ملابس الاطفال,تفضلي بزيارة متجرنا لكي تكوني الاجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),

                  ],
                ),
              ),
            ),

            //متاجر جديدة ------------------------------------------------------
            Container(
              margin: EdgeInsets.only(top: 0),

              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 5,
                  height: 40,
                  color: Colors.blue,
                ),
                SizedBox(width: 7,),
                Text("متاجر جديدة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(width: 210,),
                TextButton(
                  onPressed:()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, child:
                Text("عرض الكل"),


                ),
              ],),
            ),
            //متاجر------------------------------------------------------
            Container(
              margin: EdgeInsets.only(top: 20),
              height:310,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/daffodil.png',width: 200,height: 200,),
                          SizedBox(height: 10,),
                          Text("Daffodil | دافوديل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع ارقى واجمل ملابس الصبايا,تفضلي بزيارة متجرنا لكي تكوني الاجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/enara.png',width: 200,height: 200,),
                          SizedBox(height: 10,),
                          Text("تنويرات الشروق",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع جميع لوازم النارة في المنزل , لكي تجعل منزلك اكثر رقي تفضل بزيارة متجرنا",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/drift.jpg',width: 205,height: 209,),
                          SizedBox(height: 10,),
                          Text("Drift For Men",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع ارقى واجمل الأحذية الرجالية الاصلية ,تفضل بزيارة متجرنا واحصل على اجمل الاحذية",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/rawafed.jpg',width: 400,height: 200,),
                          SizedBox(height: 10,),
                          Text("الروافد للادوات المنزلية",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع جميع الادوات المنزلية,تفضل بزيارة متجرنا لكي تجعل بيتك اجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),
                    SizedBox(width: 15,),
                    Container(

                      width: 300,
                      child: Column(

                        children: [
                          Image.asset('assets/images/baby.jpg',width: 270,height: 207,),
                          SizedBox(height: 10,),
                          Text("Baby",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(right: 29.0),
                            child: Text("متجر الكتروني مختص ببيع ارقى واجمل ملابس الاطفال,تفضلي بزيارة متجرنا لكي تكوني الاجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                          )

                        ],),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),








    );
  }








  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
