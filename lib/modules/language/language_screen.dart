import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../login/login_screen.dart';

class LanguageScreen extends StatefulWidget {

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final items =['Arabic','English'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: onNotification,
            icon: Icon(Icons.menu, color: Colors.blue,size: 35,)),
        title: Text(
          "حدد اللغة",
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
      body:


      Padding(
        padding:const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,

              children:
              [

                SizedBox(
                  height: 20,
                ),



                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>
                      (
                      icon: Icon(Icons.language),
                      isExpanded: true,
                      value: value,
                      items: items.map(buildMenuItem).toList(),
                        onChanged:(value) => setState(() => this.value=value),
                    ),
                  ),
                ),


                SizedBox(
                  height: 20,
                ),


              ],),
          ),
        ),
      ),



    );



  }

  DropdownMenuItem<String> buildMenuItem(String item)=>
      DropdownMenuItem(value: item,
        child:
        Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15),
        )
        ,);






  void onNotification() {
    print("mama");
  }
}
