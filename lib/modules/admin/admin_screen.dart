import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
import 'package:udemy_flutter/modules/account/account_screen.dart';
import 'package:udemy_flutter/modules/admin/admin_shops_details_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  fetchData fetch = fetchData();

  Widget fetchPendingStores() {
    return FutureBuilder(
        future: fetch.allPendingStores(),
        builder: (contxt, snapchot) {
          var pendingStores = snapchot.data as List<pendingStoreModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: pendingStores == null ? 0 : pendingStores.length,
                  itemBuilder: (context, index) {
                    return myPendingStores(
                      pendingStores[index].id,
                      pendingStores[index].name,
                      pendingStores[index].description,
                      pendingStores[index].type,
                      pendingStores[index].phoneNumber,
                      pendingStores[index].location,
                      pendingStores[index].detailedLocation,
                      pendingStores[index].facebook,
                      pendingStores[index].instagram,
                      pendingStores[index].snapchat,
                      pendingStores[index].whatsapp,
                      pendingStores[index].locationOnMap,
                    );
                  });
        });
  }

  Widget myPendingStores(
      id,
      name,
      description,
      type,
      phoneNumber,
      location,
      detailedLocation,
      facebook,
      instagram,
      snapchat,
      whatsapp,
      locationOnMap) {
    return GestureDetector(
      //هاد بضم الكونتينر وكل اللي جواتو

      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminShopsDetailsScreen(
                    id,
                    name,
                    description,
                    type,
                    phoneNumber,
                    location,
                    detailedLocation,
                    facebook,
                    instagram,
                    snapchat,
                    whatsapp,
                    locationOnMap)));
      },
      child:
          //هاد الكونتينر بضم كلشي
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
              Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //         'https://www.nicepng.com/png/detail/254-2540580_we-create-a-customized-solution-to-meet-all.png'),
                  //     fit: BoxFit.cover)
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 113,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'اسم المتجر : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'وصف المتجر : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),

                      Expanded(
                          child: Text(
                        description,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 30),
                child: Image.asset(
                  'assets/images/logo3.png',
                  width: 150,
                ),
              ),
              Text(
                "متجراتي",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff758DFF)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Text(
                  "الرئيسية",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("الى المتاجر"),
                leading: Icon(Icons.store, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                width: 300,
                height: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 147),
                child: Text(
                  "معلومات المستخدم",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("حسابي"),
                leading: Icon(Icons.person, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountScreen()));
                },
              ),
              ListTile(
                title: Text("منتجات أعجبتني"),
                leading: Icon(Icons.favorite, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("منتجات طلبتها"),
                leading: Icon(Icons.add_chart, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrdersScreen()));
                },
              ),
              ListTile(
                title: Text("منتجات شاهدتها"),
                leading: Icon(Icons.remove_red_eye_outlined,
                    color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("تسجيل خروج"),
                leading: Icon(Icons.logout, color: Color(0xff758DFF)),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('token');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                width: 300,
                height: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Text(
                  "التطبيق",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff758DFF)),
                ),
              ),
              ListTile(
                title: Text("اللغة"),
                leading: Icon(Icons.g_translate, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageScreen()));
                },
              ),
              ListTile(
                title: Text("للانضمام الى متجراتي"),
                leading: Icon(Icons.person_add, color: Color(0xff758DFF)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JoinAppScreen()));
                },
              ),
              ListTile(
                title: Text("عن متجراتي"),
                leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("ضبط"),
                leading: Icon(Icons.gamepad, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("سياسة الخصوصية"),
                leading: Icon(Icons.warning, color: Color(0xff758DFF)),
                onTap: () {},
              ),
              ListTile(
                title: Text("قيم هذا التطبيق"),
                leading: Icon(Icons.star, color: Color(0xff758DFF)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
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

      body: fetchPendingStores(),
      //     //هاد بضم الكونتينر وكل اللي جواتو
      //     GestureDetector(
      //   onTap: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => AdminShopsDetailsScreen()));
      //   },
      //   child:
      //       //هاد الكونتينر بضم كلشي
      //       Container(
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(15.0),
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey,
      //           offset: Offset(0, 1.0), //(x,y)
      //           blurRadius: 5.0,
      //         ),
      //       ],
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Row(
      //         children: [
      //           Container(
      //             width: 115,
      //             height: 115,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 image: DecorationImage(
      //                     image: NetworkImage(
      //                         'https://www.nicepng.com/png/detail/254-2540580_we-create-a-customized-solution-to-meet-all.png'),
      //                     fit: BoxFit.cover)),
      //           ),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           Expanded(
      //             child: Container(
      //               height: 113,
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   Row(
      //                     children: [
      //                       Text(
      //                         'اسم المتجر : ',
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.blue),
      //                       ),
      //                       Text(
      //                         'تنويرات الشروق',
      //                         maxLines: 2,
      //                         overflow: TextOverflow.ellipsis,
      //                         style: TextStyle(),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 3,
      //                   ),
      //                   Text(
      //                     'وصف المتجر : ',
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.bold, color: Colors.blue),
      //                   ),

      //                   Expanded(
      //                       child: Text(
      //                     ' متجر متخصص لبيع كافة انواع التريات والاجهزة الكهربائية والمنزلية والمنزليةوالمنزليةوالمنزلية  ',
      //                     maxLines: 2,
      //                     overflow: TextOverflow.ellipsis,
      //                   )),
      //                   // Text('${article['publishedAt']}',style: TextStyle(color: Colors.grey,fontSize: 20),),
      //                 ],
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}



//--------------------------------------------------------------------------

