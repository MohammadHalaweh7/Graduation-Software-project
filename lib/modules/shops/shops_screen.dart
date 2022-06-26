import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/profile/profileShop_screen.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';

class ShopsScreen extends StatelessWidget
{
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
          "للأطفال",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,

          ),
        ),
        actions: [

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
        child: Container(
          width: double.infinity ,
          child: Column(
            children: [




              //متاجر------------------------------------------------------
              GestureDetector(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => ShopLayout() ));
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  child:
                  Column(

                    children:
                    [
                      Container(
                          width: 200,


                          child:

                      Image.asset('assets/images/daffodil.png',width:500,)),
                      SizedBox(height: 10,),
                      Text("Daffodil | دافوديل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(right: 29.0),
                        child: Text("متجر الكتروني مختص ببيع ارقى واجمل ملابس الصبايا,تفضلي بزيارة متجرنا لكي تكوني الاجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                      )

                    ],),
                ),
              ),
              SizedBox(height: 15,),
              Container(width: double.infinity,height: 1,color: Colors.grey,),
              SizedBox(height: 15,),

              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('assets/images/enara.png',width:double.infinity ,),
                    SizedBox(height: 0,),
                    Text("تنويرات الشروق",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(right: 29.0),
                      child: Text("متجر الكتروني مختص ببيع جميع لوازم النارة في المنزل , لكي تجعل منزلك اكثر رقي تفضل بزيارة متجرنا",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                    )

                  ],),
              ),
              SizedBox(height: 15,),
              Container(width: double.infinity,height: 1,color: Colors.grey,),
              SizedBox(height: 15,),


              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(

                  children: [
                    Image.asset('assets/images/drift.jpg',width:230,),
                    SizedBox(height: 10,),
                    Text("Drift For Men",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(right: 29.0),
                      child: Text("متجر الكتروني مختص ببيع ارقى واجمل الأحذية الرجالية الاصلية ,تفضل بزيارة متجرنا واحصل على اجمل الاحذية",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                    )

                  ],),
              ),
              SizedBox(height: 15,),
              Container(width: double.infinity,height: 1,color: Colors.grey,),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(

                  children: [
                    Image.asset('assets/images/rawafed.jpg',width: 250,),
                    SizedBox(height: 10,),
                    Text("الروافد للادوات المنزلية",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(right: 29.0),
                      child: Text("متجر الكتروني مختص ببيع جميع الادوات المنزلية,تفضل بزيارة متجرنا لكي تجعل بيتك اجمل",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                    )

                  ],),
              ),
              SizedBox(height: 15,),
              Container(width: double.infinity,height: 1,color: Colors.grey,),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(

                  children: [
                    Image.asset('assets/images/baby.jpg',width: 270,),
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








    );
  }








  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
