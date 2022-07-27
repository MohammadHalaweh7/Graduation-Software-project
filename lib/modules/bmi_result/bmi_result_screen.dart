import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {

  final int result;
  final bool isMale;
  final int age;

  BMIResultScreen({
   required this.result,
    required this.age,
    required this.isMale,
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: 
        IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("النتيجة"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("الجنس : ${isMale?"Male":"Female"}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          Text("النتيجة : $result",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          Text("العمر : $age",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        ],),
      ),
      
    );
  }
}
