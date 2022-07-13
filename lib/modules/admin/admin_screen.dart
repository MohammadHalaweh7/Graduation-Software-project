import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(
              Icons.menu,
              color: Colors.blue,
              size: 35,
            )),
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
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        //هون ديزاين الكونتينر
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      //رقم الطلب---------------------------------------------------------------------------------------------------------
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'رقم الطلب : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '48484848',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //الخط الفاصل---------------------------------------------------------------------------------------------------------
                      Container(
                        width: 300,
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //اسم المتجر---------------------------------------------------------------------------------------------------------
                      Row(
                        children: [
                          Text(
                            'اسم المتجر : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500]),
                          ),
                          Spacer(),
                          Text(
                            'تنويرات الشروق',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //وصف المتجر---------------------------------------------------------------------------------------------------------
                      Row(
                        children: [
                          Text(
                            'وصف المتجر : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500]),
                          ),
                          Spacer(),
                          Text(
                            'لمبةلمبةلمبةلمبةلمبةلمبةلمبلمبةلمبةلةلمبة حائط',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //عنوان المتجر---------------------------------------------------------------------------------------------------------
                      Row(
                        children: [
                          Text(
                            'عنوان المتجر : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500]),
                          ),
                          Spacer(),
                          Text(
                            ' المعاجين',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // المزيد من المعلومات---------------------------------------------------------------------------------------------------------
                      Row(
                        children: [
                          Text(
                            'المزيد من المعلومات....',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //  قبول او رفض
                      Row(
                        children: [
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.green, // width: double.infinity,
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                "قبول",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.red, // width: double.infinity,
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                "رفض",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}



//--------------------------------------------------------------------------

