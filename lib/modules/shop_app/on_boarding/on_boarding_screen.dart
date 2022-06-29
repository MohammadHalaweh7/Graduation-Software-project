import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/login/login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class BoardingModel
{
  final String image ;
  final String title;
  final String body;

  BoardingModel({
   required this.image,
    required this.title,
    required this.body,
});
 }

class OnBoardingScreen extends StatefulWidget
{

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
       image:'assets/images/rawafed.jpg',
      body: 'الشاشة الاولى',
      title: 'فرعي واحد'
    ),
    BoardingModel(
        image:'assets/images/rawafed.jpg',
        body: 'الشاشة الثانية',
        title: 'فرعي 2'
    ),
    BoardingModel(
        image:'assets/images/rawafed.jpg',
        body: 'الشاشة الثالثة',
        title: 'فرعي 3'
    ),
  ];

  bool isLast =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(
              onPressed: ()
              {
                navigateAndFinish(context,ShopLoginScreen());

              },

              child: Text('تخطي'))
        ],

      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index)
              {
                if(index == boarding.length - 1 )
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                else
                  {
                    isLast = false;
                  }
              },
              physics: BouncingScrollPhysics(),
              controller: boardController,
                itemBuilder: (context,index) =>buildBoardingItem(boarding[index]),
            itemCount: boarding.length,
            ),
          ),
          SizedBox(height: 40,),
          Row(
            children: [
              SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,


                ),

              ),
              Spacer(),
              FloatingActionButton(
                onPressed: ()
                {
                  if(isLast)
                    {
                      navigateAndFinish(context,LoginScreen());

                    }
                  else
                    {
                      boardController.nextPage
                        (
                          duration: Duration(
                            microseconds: 750,
                          ),
                          curve:Curves.easeInExpo);
                    };
                    }


              ,child: Icon(Icons.arrow_forward_ios),)
            ],
          )



        ],),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image:AssetImage('${model.image}') )),
      // SizedBox(height: 30,),
      Text('${model.title}',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      SizedBox(height: 15,),
      Text('${model.body}',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

    ],
  );
}
