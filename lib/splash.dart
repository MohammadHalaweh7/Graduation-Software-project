import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/sharedPrefs.dart';
import 'package:udemy_flutter/modules/admin/adminMain_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/shopkeeper/shopkeeperMain_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var type = prefs.get('type');
    if (type == 'USER') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else if (type == 'ADMIN') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminMainScreen()));
    } else if (type == 'STORE') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ShopKeeperMainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Image.asset('assets/images/logo3.png', width: 220),
      
        SizedBox(
          height: 30,
        ),
        Center(
            child: CircularProgressIndicator(
          color: Color(0xFF391248)
        )),
        Spacer(),
                                   Text(
                    "محلات فلسطين في مكان واحد",
                    style: TextStyle(
                      fontFamily:'myFont',
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF391248)),
                  ),
                  Spacer(),
       
      ],
    )));
  }
}
