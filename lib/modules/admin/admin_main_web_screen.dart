// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:udemy_flutter/API/fetchData.dart';
// import 'package:udemy_flutter/models/pendingStore/pendingStore_model.dart';
// import 'package:udemy_flutter/models/user/user_model.dart';
// import 'package:udemy_flutter/modules/account/account_screen.dart';
// import 'package:udemy_flutter/modules/admin/admin_account_screen.dart';
// import 'package:udemy_flutter/modules/admin/admin_addNotification_screen.dart';
// import 'package:udemy_flutter/modules/admin/admin_screen.dart';
// import 'package:udemy_flutter/modules/admin/admin_shops_details_screen.dart';
// import 'package:udemy_flutter/modules/admin/admin_shops_screen.dart';
// import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
// import 'package:udemy_flutter/modules/language/language_screen.dart';
// import 'package:udemy_flutter/modules/login/login_screen.dart';
// import 'package:udemy_flutter/modules/my_orders/my_orders_screen.dart';
// import 'package:http/http.dart' as http;
//
// class AdminMainWebScreen extends StatefulWidget {
//   @override
//   State<AdminMainWebScreen> createState() => _AdminMainWebScreenState();
// }
//
// class _AdminMainWebScreenState extends State<AdminMainWebScreen> {
//   // var nameController = TextEditingController();
//   // Future<UserModel> loadData() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   var token = prefs.get('token');
//   //
//   //   //print(token);
//   //
//   //   var result = await http.get(
//   //     Uri.parse(fetchData.baseURL + "/admin/me"),
//   //     headers: {
//   //       'Content-Type': 'application/json; charset=UTF-8',
//   //       'Authorization': 'Bearer ' + token.toString()
//   //     },
//   //   );
//   //   print(result.statusCode);
//   //
//   //   UserModel userModel = UserModel.fromJson(jsonDecode(result.body));
//   //
//   //   nameController.text = userModel.name;
//   //
//   //   return userModel;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return
//       FutureBuilder<UserModel>(
//       // future: loadData(),
//       builder: (context, snapshot) {
//         var account = snapshot.data;
//         if (!snapshot.hasData) {
//           return
//             Container(
//             color: Colors.white,
//             child: Center(
//               child: CircularProgressIndicator(
//                 valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
//                 backgroundColor: Colors.white,
//               ),
//             ),
//           );
//         } else {
//           return Scaffold(
//             drawer: Drawer(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8, top: 30),
//                       child: Image.asset(
//                         'assets/images/logo3.png',
//                         width: 150,
//                       ),
//                     ),
//                     Text(
//                       "متجراتي",
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff758DFF)),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 1,
//                       color: Colors.grey[300],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 220),
//                       child: Text(
//                         "الرئيسية",
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff758DFF)),
//                       ),
//                     ),
//                     ListTile(
//                       title: Text("الى الرئيسية"),
//                       leading: Icon(Icons.store, color: Color(0xff758DFF)),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AdminMainWebScreen()));
//                       },
//                     ),
//                     ListTile(
//                       title: Text("الى المتاجر"),
//                       leading: Icon(Icons.storefront, color: Color(0xff758DFF)),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AdminShopsScreen()));
//                       },
//                     ),
//                     SizedBox(
//                       height: 0,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 1,
//                       color: Colors.grey[300],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 147),
//                       child: Text(
//                         "معلومات المستخدم",
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff758DFF)),
//                       ),
//                     ),
//                     ListTile(
//                       title: Text("حسابي"),
//                       leading: Icon(Icons.person, color: Color(0xff758DFF)),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AdminAccountScreen()));
//                       },
//                     ),
//                     ListTile(
//                       title: Text("طلبات المتاجر الجديدة"),
//                       leading: Icon(Icons.person, color: Color(0xff758DFF)),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AdminScreen()));
//                       },
//                     ),
//                     ListTile(
//                       title: Text("تسجيل خروج"),
//                       leading: Icon(Icons.logout, color: Color(0xff758DFF)),
//                       onTap: () async {
//                         SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                         prefs.remove('token');
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginScreen()));
//                       },
//                     ),
//                     SizedBox(
//                       height: 0,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 1,
//                       color: Colors.grey[300],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 220),
//                       child: Text(
//                         "التطبيق",
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff758DFF)),
//                       ),
//                     ),
//                     ListTile(
//                       title: Text("اللغة"),
//                       leading:
//                       Icon(Icons.g_translate, color: Color(0xff758DFF)),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LanguageScreen()));
//                       },
//                     ),
//                     ListTile(
//                       title: Text("عن متجراتي"),
//                       leading: Icon(Icons.assignment, color: Color(0xff758DFF)),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       title: Text("ضبط"),
//                       leading: Icon(Icons.gamepad, color: Color(0xff758DFF)),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       title: Text("سياسة الخصوصية"),
//                       leading: Icon(Icons.warning, color: Color(0xff758DFF)),
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             body:
//             Stack(
//               children: <Widget>[
//                 // Container(
//                 //   height: size.height * 0.6,
//                 //   width: double.infinity,
//                 //   decoration: BoxDecoration(
//                 //       image: DecorationImage(
//                 //         alignment: Alignment.topCenter,
//                 //         image: Image.network(
//                 //             "https://www.optrocom.net/sitepad-data/uploads//2021/05/header5.png")
//                 //             .image,
//                 //       )),
//                 // ),
//                 SafeArea(
//                   child: Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(bottom: 0),
//                           height: 64,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               // CircleAvatar(
//                               //   radius: 38,
//                               //   // backgroundImage: NetworkImage(
//                               //   //     'https://j-rak.org.sa/wp-content/uploads/2021/02/5f406ab25e8942cbe0da6485afd26b71.jpg'),
//                               //   backgroundImage: account!.avatar == null
//                               //       ? (NetworkImage(
//                               //     'https://j-rak.org.sa/wp-content/uploads/2021/02/5f406ab25e8942cbe0da6485afd26b71.jpg',
//                               //   ) as ImageProvider)
//                               //       : MemoryImage(
//                               //     base64Decode(account.avatar.toString()),
//                               //   ),
//                               // ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   // Text(
//                                   //   account.name,
//                                   //   style: TextStyle(
//                                   //       color: Colors.white,
//                                   //       fontWeight: FontWeight.bold,
//                                   //       letterSpacing: 2,
//                                   //       fontStyle: FontStyle.italic,
//                                   //       fontSize: 16.5),
//                                   // ),
//                                   Text(
//                                     'Admin',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         letterSpacing: 2,
//                                         fontSize: 11),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Expanded(
//                           child: GridView.count(
//                             mainAxisSpacing: 10,
//                             crossAxisSpacing: 10,
//                             childAspectRatio: 1 / 1.3,
//                             crossAxisCount: 2,
//                             primary: false,
//                             children: <Widget>[
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               AdminShopsScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.network(
//                                         "https://hebergement-site-web.ma/hebergement-site-prestashop/wp-content/uploads/sites/24/2021/04/Selection_147.png",
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'جميع المتاجر',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               AdminAccountScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.asset(
//                                         'assets/images/adminIMG.jpg',
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'حسابي',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => AdminScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.network(
//                                         'https://thumbs.dreamstime.com/b/document-icons-add-remove-buttons-symbol-set-royalty-free-vector-illustration-95581404.jpg',
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'طلبات المتاجر الجديدة',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   // Navigator.push(context,MaterialPageRoute(builder: (context) => AdminScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.network(
//                                         "https://theyarnbazaar.com/images/FInance.png",
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'المالية',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   // Navigator.push(context,MaterialPageRoute(builder: (context) => AdminScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.network(
//                                         "https://img.freepik.com/premium-vector/research-finance-sales-data-audit-mobile-phone-report-online-statistics-info-analysis-smartphone-vector-flat-cartoon-isolated_212005-118.jpg",
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'الاحصائيات',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(context,MaterialPageRoute(builder: (context) => AddNotificationScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.asset(
//                                         'assets/images/notification.png',
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'التنبيهات',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//                                   SharedPreferences prefs =
//                                   await SharedPreferences.getInstance();
//                                   prefs.remove('token');
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => LoginScreen()));
//                                 },
//                                 child: Card(
//                                   elevation: 15,
//                                   shadowColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Image.network(
//                                         "https://us.123rf.com/450wm/faysalfarhan/faysalfarhan1710/faysalfarhan171013860/88895640-logout-icon-isolated-on-special-red-square-button-abstract-illustration.jpg?ver=6",
//                                         height: 128,
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         'تسجيل الخروج',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   void onNotification() {
//     var ScaffoldKey;
//     ScaffoldKey.currentState?.openDrawer();
//   }
// }
//
//
//
// //--------------------------------------------------------------------------
//