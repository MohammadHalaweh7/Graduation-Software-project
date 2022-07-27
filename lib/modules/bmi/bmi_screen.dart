// import 'dart:html';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/bmi_result/bmi_result_screen.dart';

class  BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height=120;
  int age =20;
  int weight=40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حاdddddddسبة bmis"),
      ),
      body:
      Column(
        children: [
        Expanded(
          child:
          //--------------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            Row(children: [
              GestureDetector(
                onTap: ()
                {
                  setState(() {
                    isMale=true;
                  });



                },
                child: Expanded(
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image(image: AssetImage("assets/images/profile2.jpg"),width: 90,height: 90,),
                      Text("ذكر",style: TextStyle(fontSize: 30),)
                    ],),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                  color: isMale ? Colors.blue:Colors.grey
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      isMale=false;
                    });
                  },
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage("assets/images/profile3.jpg"),width: 90,height: 90,),
                        Text("انثى",style: TextStyle(fontSize: 30),)
                      ],),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !isMale ? Colors.blue:Colors.grey
                    ),
                  ),
                ),
              ),
            ],
            ),
          ),
        ),
        //--------------------------------------------------------------------
        Expanded(
          child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("الارتفاع",style: TextStyle(fontSize: 20 ),),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
    Text("${height.round()}",style: TextStyle(fontSize: 40),),
    Text("cm"),

    ],
    ),
                Slider(
                    value: height,
                    max: 220.0,
                    onChanged: (value)
                    {
                      setState(() {
                        height=value;
                      });
                      print(value);
                    })

    ],),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey,),

            ),
          )
          ),
        //--------------------------------------------------------------------
        Expanded(
          child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: [
                Expanded(
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text("ألعمر",style: TextStyle(fontSize: 30),),
                      Text("${age}",style: TextStyle(fontSize: 30),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                        FloatingActionButton(
                          heroTag: "age--",
                          mini: true,onPressed: (){setState(() {
                          age--;
                        });},


                          child: Icon(Icons.remove),),
                        FloatingActionButton(
                          heroTag: "age++",
                          mini: true,onPressed: (){setState(() {
                          age++;
                        });},child: Icon(Icons.add),)

                      ],)
                    ],),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.grey
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                child: Container(

                child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text("الوزن",style: TextStyle(fontSize: 30),),
    Text("$weight",style: TextStyle(fontSize: 30),),
    Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

    FloatingActionButton(
      heroTag: "weight--",
      mini: true,onPressed: (){setState(() {
      weight--;
    });},child: Icon(Icons.remove),),
    FloatingActionButton(
      heroTag: "weight++",

      mini: true,onPressed: (){setState(() {
      weight++;
    });},child: Icon(Icons.add),)

    ],)
    ],),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color:Colors.grey
    ),
    ),
    ),
              ],),
            )

        ),
        //--------------------------------------------------------------------
        Container(
            width:double.infinity ,
            color: Colors.blue,
            child: MaterialButton(onPressed:()
            {
              var result = weight / pow(height / 100,2);
              print(result.round());
              Navigator.push(context, MaterialPageRoute(builder:(context) => BMIResultScreen(age: age,result:result.round(),isMale: isMale,) ));            },
              child: Text("احسب",style: TextStyle(color: Colors.white),),))
      ],),
    );
  }
}
