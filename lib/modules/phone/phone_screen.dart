import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';

class PhoneScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(Icons.menu, color: Colors.blue,size: 35,)),
        title: Text(
          "تسجيل الدخول عبر الهاتف",
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
                onTap:(){} ,
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
                onTap:(){} ,
              ),
              ListTile(
                title: Text("للانضمام الى متجراتي"),
                leading: Icon(Icons.person_add,color:Color(0xff758DFF)),
                onTap:(){} ,
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
                leading: Icon(Icons.star_border,color:Color(0xff758DFF)),
                onTap:(){} ,
              ),

            ],
          ),
        ),
      ),
      body:

      Padding(
        padding:const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset('assets/images/logo3.png',width: 170,),
                Text("متجراتي",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),),
                SizedBox(
                  height: 30,
                ),


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
                    labelText: "اسم المستخدم",
                    prefixIcon: Icon(Icons.person),
                    border:OutlineInputBorder(),

                  ),
                ),

                SizedBox(
                  height: 10,
                ),

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
                    labelText: "رقم الهاتف",
                    prefixIcon: Icon(Icons.phone),
                    border:OutlineInputBorder(),

                  ),
                ),

                SizedBox(
                  height: 10,
                ),


                SizedBox(
                  height: 20,
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.blueAccent,                      // width: double.infinity,
                  ),

                  child: MaterialButton(

                    onPressed:(){
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    child:
                    Text("قم بتسجيل الدخول باستخدام الهاتف",style: TextStyle(color: Colors.white),),



                  ),
                ),
                SizedBox(
                  height: 30,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed:()
                      {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                      }
                      , child:
                    Text("العودة الى تسجيل الدخول ؟"),
                    ),


                  ],)












              ],),
          ),
        ),
      ),



    );
  }












  void onNotification() {
    print("mama");
  }
}
