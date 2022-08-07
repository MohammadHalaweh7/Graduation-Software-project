import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/news_app/business/business_screen.dart';
import 'package:udemy_flutter/modules/news_app/science/science_screen.dart';
import 'package:udemy_flutter/modules/news_app/settings/settings_screen.dart';
import 'package:udemy_flutter/modules/news_app/sports/sports_screen.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialStates());


  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems =
      [
        BottomNavigationBarItem(
            icon: Icon(Icons.business),
          label: "Business"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: "sports"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: "science"
        ),
      ];
  List<Widget> screen =
  [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavStates());
  }
  //for business----------------------------------------------------------------
  List<dynamic> business = [];
  void getbusiness()
  {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        }
    ).then((value)
    {
      // print(value.data['articles'][0]['title']);
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessStates());

    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));

    });
  }

  //for sports------------------------------------------------------------------
  List<dynamic> sports = [];
  void getsports()
  {
    emit(NewsGetSportsLoadingStates());
    //if(sports.length==0)
    //  {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query:
            {
              'country':'eg',
              'category':'sports',
              'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
            }
        ).then((value)
        {
          // print(value.data['articles'][0]['title']);
          sports=value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessStates());

        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorStates(error.toString()));

        });
    //  }

   // else
    //  {
        emit(NewsGetSportsSuccessStates());

    //  }

  }

  //for science------------------------------------------------------------------
  List<dynamic> science = [];
  void getscience()
  {
    emit(NewsGetScienceLoadingStates());
    //if(sports.length==0)
    //  {
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        }
    ).then((value)
    {
      // print(value.data['articles'][0]['title']);
      science=value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessStates());

    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorStates(error.toString()));

    });
    //  }

    // else
    //  {
    emit(NewsGetScienceSuccessStates());

    //  }

  }

  //for search------------------------------------------------------------------


  // List<dynamic> search = [];
  // void getSearch()
  // {
  //   emit(NewsGetSearchLoadingStates());
  //   search = [];
  //
  //   DioHelper.getData(
  //       url: 'v2/everything',
  //       query:
  //       {
  //         'q':'$value',
  //         'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
  //       }
  //   ).then((value)
  //   {
  //     search=value.data['articles'];
  //     print(search[0]['title']);
  //     emit(NewsGetSearchSuccessStates());
  //
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(NewsGetSearchErrorStates(error.toString()));
  //
  //   });
  //
  //
  // }

}
