import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 35,
            )),
        title: Text(
          "الاشعارات",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body:
          //هاد بضم كلشي
          Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              //هاد للصورة
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://www.cmarix.com/blog/wp-content/uploads/2020/07/The-best-eCommerce-platform-for-Food-delivery.png'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //The title
                      Text(
                        'متجر تنويرات الشروق',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      //The description
                      Expanded(
                          child: Text(
                        'خصم 10 % على جميع التريات الموجودة داخل المعرض والعرض لمدة اسبوعين فقط',
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),

                      // Text('${article['publishedAt']}',style: TextStyle(color: Colors.grey,fontSize: 20),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //مش مهم
  void onNotification() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}

//--------------------------------------------------------------------------
