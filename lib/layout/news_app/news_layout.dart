import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/news_app_search/news_search_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getbusiness()..getsports()..getscience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder:  (context, state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("الاخبار دة"),
              actions: [
                IconButton(onPressed: (){

                  // navigateTo(context,NewsSearchScreen);


                },
                    icon:Icon(Icons.search,) ),
                IconButton(
                    onPressed: ()
                {
                  AppCubit.get(context).changeAppMode();
                },
                    icon:Icon(Icons.brightness_4_rounded) ),
              ],
            ),
            body:cubit.screen[cubit.currentIndex] ,
            bottomNavigationBar: BottomNavigationBar(
          items: cubit.bottomItems,
          currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottomNavBar(index);

          },
          ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: ()
            //   {
            //     // DioHelper.getData(
            //     //     url: 'v2/top-headlines',
            //     //     query:
            //     //     {
            //     //       'country':'eg',
            //     //       'category':'business',
            //     //       'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
            //     //     }
            //     // ).then((value)
            //     // {
            //     //   print(value.data['articles'][0]['title']);
            //     // }).catchError((error){
            //     //   print(error.toString());
            //     // });
            //   },
            //
            //   child: Icon(Icons.add),
            // ),


          );
        },


      ),
    );
  }
}






