import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  List<int> i = [
    3,
    4,
    5,
    6,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 20,
          title: Row(children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage:AssetImage('assets/images/profile.jpg'),

            ),
            SizedBox(
              width: 10,
            ),
            Text("الدردشات",style: TextStyle(color: Colors.black),),


          ],),

          actions: [
            IconButton(onPressed: (){},
                icon: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 16.0,
                    child: Icon(Icons.camera_alt_outlined,size: 20,color: Colors.white,))),
            IconButton(onPressed: (){},
                icon: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 16.0,
                    child: Icon(Icons.edit,size: 20,color: Colors.white,))),
          ],



        ),


        body: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey[300],

                  ),
                  child: Row(children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Search"),
                  ],),
                ),




                SizedBox(height: 10,),



                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile2.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),

                          SizedBox(height: 4,),
                          Text("سيرين",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile4.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Haifa",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Mohammad",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile3.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Serrin",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile5.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("نانسي عجرم",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Mohammad",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Mohammad",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Mohammad",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 90,
                        child: Column(children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage:AssetImage('assets/images/profile.jpg'),

                              ),
                              CircleAvatar(
                                radius: 11.5,
                                backgroundColor: Colors.white,

                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,

                              ),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text("Mohammad",maxLines: 2,overflow: TextOverflow.ellipsis,)
                        ],),
                      ),
                      SizedBox(width: 20,),

                    ],
                  ),
                ),








                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile2.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("سيرين عبد النور",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                          Row(children: [
                            Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 10,
                              height: 10,
                              decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                              ),
                            ),
                            Text("3:10 pm"),

                          ],),
                            SizedBox(height: 5,),

                        ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile3.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Serrin Abdl Noor",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("محمممممممد انا سيرين جيتك من حسابي الرسمي عبرنييي",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile4.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Haifa Wehbe",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("محمد حبيبي كيفك انا هيفا",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile5.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("نانسي عجرم",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("محمد هلا هلا بدك تيجي تتزوجني بليييييز ومبدي مهر منك يا حياتي",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:AssetImage('assets/images/profile.jpg'),

                          ),
                          CircleAvatar(
                            radius: 11.5,
                            backgroundColor: Colors.white,

                          ),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.green,

                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mohammad Halaweh",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                                ),
                              ),
                              Text("3:10 pm"),

                            ],),
                            SizedBox(height: 5,),

                          ],),
                      )
                    ],
                  ),




                



              ],),
            )


        ));
  }



  Widget buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundImage:AssetImage('assets/images/profile2.jpg'),

          ),
          CircleAvatar(
            radius: 11.5,
            backgroundColor: Colors.white,

          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.green,

          ),
        ],
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("سيرين عبد النور",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            SizedBox(height: 5,),
            Row(children: [
              Expanded(child: Text("مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",maxLines: 2,overflow: TextOverflow.ellipsis,)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),

                ),
              ),
              Text("3:10 pm"),

            ],),
            SizedBox(height: 5,),

          ],),
      )
    ],
  );











  Widget buildStoryItem() => Container(
    width: 90,
    child: Column(children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundImage:AssetImage('assets/images/profile2.jpg'),

          ),
          CircleAvatar(
            radius: 11.5,
            backgroundColor: Colors.white,

          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.green,

          ),
        ],
      ),

      SizedBox(height: 4,),
      Text("سيرين",maxLines: 2,overflow: TextOverflow.ellipsis,)
    ],),
  );













  void onNotification() {
    print("mama");
  }
}
