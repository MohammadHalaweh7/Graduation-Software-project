import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class sqfliteScreen extends StatefulWidget {

  @override
  _sqfliteScreenState createState() => _sqfliteScreenState();
}

class _sqfliteScreenState extends State<sqfliteScreen> {
  var database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var fabIcon;
  bool isBottomSheetShown=false;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("داتا بيس"),
      ),
      body:Text("d"),
      floatingActionButton:FloatingActionButton(
        onPressed:()
    {
      if(isBottomSheetShown)
        {
          Navigator.pop(context);
          isBottomSheetShown=false;
          setState(() {
            fabIcon=Icons.edit;
          });
        }
      else
        {
          scaffoldKey.currentState?.showBottomSheet((context) => Container(
            width: double.infinity,
            height: 120.0,
            color: Colors.red,
          ),
          );
          isBottomSheetShown=true;
          setState(() {
            fabIcon=Icons.add;
          });
        }
    },

    child:Icon(Icons.add),

    ),
    );
  }



  Future<void> createDatabase()
  async {
     database = await openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database,version)
        {
          print("Database Created");
           database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)').then((value)
           {
             print("Table Created");

           }).catchError((error)
           {
             print("Error when creating table ${error.toString()}");
           });
        },
      onOpen: (database)
        {
          print("Database Opened");
        },
    );




  }

  Future<void> insertToDatabase()
  async {

    await database.transaction((txn) async {
      int id1 = await txn.rawInsert
      (
          'INSERT INTO tasks(title, date, time,status) VALUES ("First task","0222","891","new")'
      ).then((value)
      {
        print("$value Inserted Succssesfuly");

      }).catchError((error)
      {
        print("Error when inserting new recoed ${error.toString()}");
      });

    });

  }
}
