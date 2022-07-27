import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MassengerScreen extends StatelessWidget {
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
          title: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "اxلدردشاتh",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 16.0,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: Colors.white,
                    ))),
            IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 16.0,
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ))),
          ],
        ),
        body:
        SingleChildScrollView(
            // scrollDirection: Axis.horizontal,
            child: Padding(
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
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Search"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 105.0,
                child:
                ListView.separated(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildStoryItem(),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 0,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20.0,
                  ),
                  itemCount: 20),


            ],
          ),
        )));
  }



  Widget buildStoryItem() => Container(
        width: 90,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/images/profile2.jpg'),
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
            SizedBox(
              height: 4,
            ),
            Text(
              "سيرين",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
  Widget buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundImage: AssetImage('assets/images/profile2.jpg'),
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
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "سيرين عبد النور",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                      "مرحبا محمد كيفك انا معجبة فيك ميتة عليك مشان الله",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                ),
                Text("3:10 pm"),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      )
    ],
  );











  void onNotification() {
    print("mama");
  }
}
