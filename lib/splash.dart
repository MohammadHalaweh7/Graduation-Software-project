import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';

 class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() =>_SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
     _navigatetohome();
  }

  _navigatetohome()async {
  await Future.delayed(Duration(milliseconds:3000 ),(){});
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainScreen()));            
                 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: 
        Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
         [
        Image.asset('assets/images/logo3.png',width: 180),
        Text("محلاتي",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
            ),
            SizedBox(height: 10,),
            

        Center(child: CircularProgressIndicator(color: Colors.blue,)),
        ],
        )

      )
    );
    
  }
}