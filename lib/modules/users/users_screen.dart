import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_model.dart';





class UsersScreen extends StatelessWidget {

  List<UserModel> users = [
    UserModel(
      id:1,
      name:"Mohammad Halaweh",
      phone: "00970598939763",
    ),
    UserModel(
      id:2,
      name:"Ahmad Halaweh",
      phone: "0097054639763",
    ),
    UserModel(
      id:3,
      name:"Tayseer Halaweh",
      phone: "41541559763",
    ),    UserModel(
      id:1,
      name:"Mohammad Halaweh",
      phone: "00970598939763",
    ),
    UserModel(
      id:2,
      name:"Ahmad Halaweh",
      phone: "0097054639763",
    ),
    UserModel(
      id:3,
      name:"Tayseer Halaweh",
      phone: "41541559763",
    ),
    UserModel(
      id:2,
      name:"Ahmad Halaweh",
      phone: "0097054639763",
    ),
    UserModel(
      id:3,
      name:"Tayseer Halaweh",
      phone: "41541559763",
    ),    UserModel(
      id:1,
      name:"Mohammad Halaweh",
      phone: "00970598939763",
    ),
    UserModel(
      id:2,
      name:"Ahmad Halaweh",
      phone: "0097054639763",
    ),
    UserModel(
      id:3,
      name:"Tayseer Halaweh",
      phone: "41541559763",
    ),
    UserModel(
      id:2,
      name:"Ahmad Halaweh",
      phone: "0097054639763",
    ),
    UserModel(
      id:3,
      name:"Tayseer Halaweh",
      phone: "41541559763",
    ),    UserModel(
      id:1,
      name:"Mohammad Halaweh",
      phone: "00970598939763",
    ),
    UserModel(
      id:2,
      name:"Ahmad Halaweh",
      phone: "0097054639763",
    ),
    UserModel(
      id:3,
      name:"Tayseer Halaweh",
      phone: "41541559763",
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("المستخدمين"),
      ),
      body:
      ListView.separated(
          itemBuilder: (context,index) =>buildUsersItem(users[index]),
          separatorBuilder: (context,index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ),
          itemCount: users.length),
    );
  }







  Widget buildUsersItem(UserModel users) =>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(children: [
      CircleAvatar(
        radius: 25.0,
        child:
        Text("${users.id}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
        ,),
      SizedBox(width: 20,),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${users.name}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            Text("${users.phone}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),



          ],),
      )

    ],),
  ) ;




}
