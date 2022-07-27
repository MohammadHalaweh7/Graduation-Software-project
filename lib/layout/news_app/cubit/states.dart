abstract class NewsStates {}

class NewsInitialStates extends  NewsStates{}

class NewsBottomNavStates extends NewsStates{}


//for Business------------------------------------------------------------------
class NewsGetBusinessLoadingStates extends NewsStates{}

class NewsGetBusinessSuccessStates extends NewsStates{}

class NewsGetBusinessErrorStates extends NewsStates{
  final String error;
  NewsGetBusinessErrorStates(this.error);
}

//for sports--------------------------------------------------------------------
class NewsGetSportsLoadingStates extends NewsStates{}

class NewsGetSportsSuccessStates extends NewsStates{}

class NewsGetSportsErrorStates extends NewsStates{
  final String error;
  NewsGetSportsErrorStates(this.error);
}
//for Science------------------------------------------------------------------
class NewsGetScienceLoadingStates extends NewsStates{}

class NewsGetScienceSuccessStates extends NewsStates{}

class NewsGetScienceErrorStates extends NewsStates{
  final String error;
  NewsGetScienceErrorStates(this.error);
}
//for Search------------------------------------------------------------------
// class NewsGetSearchLoadingStates extends NewsStates{}
//
// class NewsGetSearchSuccessStates extends NewsStates{}
//
// class NewsGetSearchErrorStates extends NewsStates{
//   final String error;
//   NewsGetSearchErrorStates(this.error);
// }