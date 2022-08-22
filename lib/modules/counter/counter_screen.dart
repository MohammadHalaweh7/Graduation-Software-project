import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  var counter=0;

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عداد"),
      ),
      body: Center(
        child:
        
         Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [

          TextButton(onPressed: (){
            setState(() {
              counter--;
            });

          },
              child:
          Text("نقص"),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Text("$counter",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 60),),
          ),
          TextButton(onPressed: (){

            setState(() {
              counter++;
            });
          },
            child:
            Text("زيد"),

          ),

        ],),
      ),
    );
  }
}
