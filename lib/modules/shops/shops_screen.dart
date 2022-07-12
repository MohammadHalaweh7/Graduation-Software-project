import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/models/store_model.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/language/language_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/profile/profileShop_screen.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';

var type;
var title;

class ShopsScreen extends StatefulWidget {
  setType(S) {
    type = S;
    //  print(type);
  }

  setTitle(S) {
    title = S;
    //  print(type);
  }

  String getType() {
    // print(type);
    return type;
  }

  String getTitle() {
    // print(type);
    return title;
  }

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  fetchData fetch = fetchData();

  Widget fetchTypeStores() {
    return FutureBuilder(
        future: fetch.alltypestores(ShopsScreen().getType()),
        builder: (contxt, snapchot) {
          var stores = snapchot.data as List<StoreModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: stores == null ? 0 : stores.length,
                  itemBuilder: (context, index) {
                    return mystore(
                      stores[index].name,
                      stores[index].description,
                      stores[index].id,
                      stores[index].phoneNumber,
                      stores[index].locationOnMap,
                    );
                  });
        });
  }

  Widget mystore(name, description, id, phoneNumber, locationOnMap) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GestureDetector(
        onTap: () {
          ShopLayout()
              .setData(id, name, description, phoneNumber, locationOnMap);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShopLayout()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1.0), //(x,y)
                blurRadius: 15.0,
              ),
            ],
          ),
          margin: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: 391,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://mystoreapii.herokuapp.com/store/' +
                              id +
                              '/avatar',
                        ),
                        fit: BoxFit.cover),
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 29.0),
                child: Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   width: double.infinity,
              //   height: 1,
              //   color: Colors.grey,
              // )
            ],
          ),
        ),
      ),
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
          ShopsScreen().getTitle(),
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
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
                      MaterialPageRoute(builder: (context) => LoginScreen()));
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
                onTap: () {},
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
      body: Center(child: fetchTypeStores()),
    );
  }

  void onNotification() {
    var ScaffoldKey;
    ScaffoldKey.currentState?.openDrawer();
  }
}
