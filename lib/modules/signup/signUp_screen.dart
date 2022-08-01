import 'dart:convert';
// import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool isPassword = true;

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
    if (userNameController.text == '' ||
        emailController.text == '' ||
        passwordController.text == '' ||
        interests == []) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
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
    if (result.statusCode == 413) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog2(context),
      );
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
              Icons.arrow_back,
              color: Colors.blue,
              size: 35,
            )),
        title: Text(
          "انشاء حساب".tr,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                        'الصورة الشخصية'.tr,
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
                    labelText: "اسم المستخدم".tr,
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
                    labelText: "البريد الالكتروني".tr,
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
                  obscureText: isPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "الرجاء ادخال كلمة السر".tr;
                    }
                    return null;
                  },
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    // hintText: "البريد الالكتروني",
                    labelText: "كلمة السر".tr,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        icon: isPassword
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off)),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          'حدد اهتماماتك : '.tr,
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'للأطفال'.tr,
                                style: TextStyle(fontSize: 10),
                              ),
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
                              Text("الكترونيك".tr,
                                  style: TextStyle(fontSize: 10)),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Arts,
                                onChanged: (val) {
                                  setState(() {
                                    Arts = val!;
                                    interests.add("الكترونيك");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("اكسسوارات".tr,
                                  style: TextStyle(fontSize: 10)),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("انارة".tr, style: TextStyle(fontSize: 10)),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: Gifts,
                                onChanged: (val) {
                                  setState(() {
                                    Gifts = val!;
                                    interests.add("انارة");
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("عطور".tr, style: TextStyle(fontSize: 10)),
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
                              Text("ملابس".tr, style: TextStyle(fontSize: 10)),
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
                              Text("أحذية".tr, style: TextStyle(fontSize: 10)),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("ماكولات".tr,
                                  style: TextStyle(fontSize: 10)),
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
                              Text('للسيدات'.tr,
                                  style: TextStyle(fontSize: 10)),
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
                              Text("للرجال".tr, style: TextStyle(fontSize: 10)),
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
                      "تسجيل".tr,
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
                        "هل تريد انشاء متجر ؟ انشأه الان!".tr,
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

  //Pub up Function(2)--------------------------------------------------------------------------------------------
  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              radius: 17,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.check,
                color: Colors.white,
              )),
          SizedBox(
            height: 10,
          ),
          Text("الرجاء ادخال جميع الحقول ")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }

  Widget _buildPopupDialog2(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              radius: 17,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.check,
                color: Colors.white,
              )),
          SizedBox(
            height: 10,
          ),
          Text("حجم الصورة تجاوز الحد المسموح")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('موافق'.tr),
        ),
      ],
    );
  }

  void onNotification() {
    Navigator.pop(context);
  }
}
