import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/models/notification/notification_model.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';

import '../../API/fetchData.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  fetchData fetch = fetchData();
  List<NotificationModel> notifications = [];
  Widget getAllNotifications() {
    return FutureBuilder(
        future: fetch.allNotifications(),
        builder: (contxt, snapchot) {
          notifications =
              snapchot.hasData ? snapchot.data as List<NotificationModel> : [];
          return !snapchot.hasData
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notifications == null ? 0 : notifications.length,
                  itemBuilder: (context, index) {
                    return mynotifications(
                      notifications[index].title,
                      notifications[index].description,
                      notifications[index].avatar,
                    );
                  });
        });
  }

  Widget mynotifications(title, description, avatar) {
    return //هاد بضم كلشي
        Column(
      children: [
        SizedBox(
          height: 10,
        ),
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
                        image: avatar == null
                            ? (NetworkImage(
                                'https://www.cmarix.com/blog/wp-content/uploads/2020/07/The-best-eCommerce-platform-for-Food-delivery.png',
                              ) as ImageProvider)
                            : MemoryImage(
                                base64Decode(avatar),
                              ),
                        fit: BoxFit.cover),
                  ),
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
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        //The description
                        Expanded(
                            child: Text(
                          description,
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
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

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
      body: getAllNotifications(),
    );
  }

  //مش مهم
  void onNotification() {
    Navigator.pop(context);
  }
}

//--------------------------------------------------------------------------
