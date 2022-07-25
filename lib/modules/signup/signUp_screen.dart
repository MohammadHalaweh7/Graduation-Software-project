import 'dart:convert';
// import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/API/fetchData.dart';
import 'package:udemy_flutter/API/sharedPrefs.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/shared/components/components.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//  هدول لل شيك بوكس
  bool baby = false;
  bool women = false;
  bool men = false;
  bool Accessori = false;
  bool Gifts = false;
  bool Foods = false;
  bool Clothes = false;
  bool shoes = false;
  bool perfume = false;
  bool Arts = false;

  List<String> interests = [];

  File? _image;
  var myImage;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    myImage = image;

    setState(() {
      this._image = imageTemporary;
    });
  }

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var userNameController = TextEditingController();

  Future<void> SignUp(BuildContext context) async {
    print(userNameController.text);
    print(emailController.text);
    print(passwordController.text);
    var body;
    if (!(myImage == null)) {
      var bytes = await new File(myImage.path).readAsBytes();
      String base64 = base64Encode(bytes);
      body = jsonEncode({
        'name': userNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'avatar': base64,
        'interests': interests
      });
    } else {
      body = jsonEncode({
        'name': userNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'interests': interests
      });
    }

    //print(body);
    var result = await http.post(Uri.parse(fetchData.baseURL + "/users"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body);

    print(result.statusCode);

    if (result.statusCode == 201) {
      var body = jsonDecode(result.body);
      sharedPrefs.saveToken(body['token']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
      // navigateTo(context,MainScreen());
    }
  }

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
          "تسجيل الدخول",
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
                onTap: () {},
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
                onTap: () {},
              ),
              ListTile(
                title: Text("للانضمام الى متجراتي"),
                leading: Icon(Icons.person_add, color: Color(0xff758DFF)),
                onTap: () {},
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
                leading: Icon(Icons.star_border, color: Color(0xff758DFF)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/images/logo3.png',
                  width: 170,
                ),
                Text(
                  "متجراتي",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 30,
                ),

                //الصورة الشخصية------------------------------------------------------------------------------------------------------
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'الصورة الشخصية',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 52.0,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          _image!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      'http://futosite.teneceschoolsupport.com/wp-content/uploads/2022/01/1-1.png',
                                      width: 90,
                                      height: 90,
                                    )),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                            ),
                            Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height: 120.0,
                  padding: EdgeInsets.all(12),
                  margin: const EdgeInsets.only(
                      bottom: 6.0,
                      right: 1,
                      left: 1), //Same as `blurRadius` i guess

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 0.0), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                //اسم المستخدم------------------------------------------------------------------------------------------------------
                TextFormField(
                  controller: userNameController,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    // hintText: "البريد الالكتروني",
                    labelText: "اسم المستخدم",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //البريد الالكتروني------------------------------------------------------------------------------------------------------
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    // hintText: "البريد الالكتروني",
                    labelText: "البريد الالكتروني",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //كلمة السر-----------------------------------------------------------------------------------------------------------
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    // hintText: "البريد الالكتروني",
                    labelText: "كلمة السر",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),

                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 13),
                //اهتماماتك--------------------------------------------------------------------------------------
                Container(
                  height: 205.0,
                  padding: EdgeInsets.all(12),
                  margin: const EdgeInsets.only(
                      bottom: 6.0,
                      right: 1,
                      left: 1), //Same as `blurRadius` i guess

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 0.0), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'حدد اهتماماتك : ',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text('للأطفال'),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: baby,
                                onChanged: (val) {
                                  setState(() {
                                    baby = val!;
                                    interests.add("للأطفال");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('للسيدات'),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: women,
                                onChanged: (val) {
                                  setState(() {
                                    women = val!;
                                    interests.add("للسيدات");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("للرجال"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: men,
                                onChanged: (val) {
                                  setState(() {
                                    men = val!;
                                    interests.add("للرجال");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("اكسسوارات"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Accessori,
                                onChanged: (val) {
                                  setState(() {
                                    Accessori = val!;
                                    interests.add("اكسسوارات");
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("هدايا"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Gifts,
                                onChanged: (val) {
                                  setState(() {
                                    Gifts = val!;
                                    interests.add("هدايا");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("ماكولات"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Foods,
                                onChanged: (val) {
                                  setState(() {
                                    Foods = val!;
                                    interests.add("ماكولات");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("ملابس"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Clothes,
                                onChanged: (val) {
                                  setState(() {
                                    Clothes = val!;
                                    interests.add("ملابس");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("أحذية"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: shoes,
                                onChanged: (val) {
                                  setState(() {
                                    shoes = val!;
                                    interests.add("أحذية");
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("عطور"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: perfume,
                                onChanged: (val) {
                                  setState(() {
                                    perfume = val!;
                                    interests.add("عطور");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("فنون"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Arts,
                                onChanged: (val) {
                                  setState(() {
                                    Arts = val!;
                                    interests.add("فنون");
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                //تسجيل---------------------------------------------------------------------------------------------------------
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.blueAccent, // width: double.infinity,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      SignUp(context);
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    child: Text(
                      "تسجيل",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinAppScreen()));
                      },
                      child: Text(
                        "هل تريد انشاء متجر ؟ انشأه الان!",
                        style: TextStyle(
                            fontSize: 16.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onNotification() {
    print("mama");
  }
}
