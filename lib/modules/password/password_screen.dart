import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../login/login_screen.dart';

class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(Icons.arrow_back, color: Colors.blue,size: 35,)),
        title: Text(
          "هل نسيت كلمة المرور !",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,

          ),
        ),
        actions: [

        ],
      ),
      body:


      Padding(
        padding:const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key:formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Image.asset('assets/images/logo3.png',width: 170,),
                  Text("متجراتي",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),),
                  SizedBox(
                    height: 80,
                  ),


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
                        return"حط رقم السر يا بيبي";
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      // hintText: "البريد الالكتروني",
                      labelText: "البريد الالكتروني",
                      prefixIcon: Icon(Icons.email),
                      border:OutlineInputBorder(),

                    ),
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
                        if(formkey.currentState!.validate())
                        {
                          print(emailController.text);
                          print(passwordController.text);
                        }

                      },
                      child:
                      Text("ارسال",style: TextStyle(color: Colors.white),),



                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                      Text("عضو بالفعل؟ سجل الدخول!",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),


                    ],)












                ],),
            ),
          ),
        ),
      ),



    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}
