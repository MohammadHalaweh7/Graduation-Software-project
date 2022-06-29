
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy_flutter/modules/cart/cart_screen.dart';
import 'package:udemy_flutter/modules/counter/counter_screen.dart';
import 'package:udemy_flutter/modules/home/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:udemy_flutter/modules/join/joinApp_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/messenger/massenger_screen.dart';
import 'package:udemy_flutter/modules/more/more_screen.dart';
import 'package:udemy_flutter/modules/password/password_screen.dart';
import 'package:udemy_flutter/modules/phone/phone_screen.dart';
import 'package:udemy_flutter/modules/profile/profileShop_screen.dart';
import 'package:udemy_flutter/modules/search/search_screen.dart';
import 'package:udemy_flutter/layout/shop_layout/shop_layout.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/modules/shops/shops_screen.dart';
import 'package:udemy_flutter/modules/signup/signUp_screen.dart';
import 'package:udemy_flutter/modules/udemy_responsive/mobile.dart';
import 'package:udemy_flutter/modules/udemy_responsive/web.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'package:udemy_flutter/sqflite.dart';
import 'package:udemy_flutter/modules/users/users_screen.dart';
import 'package:udemy_flutter/modules/bmi/bmi_screen.dart';
import 'layout/news_app/news_layout.dart';
import 'modules/bmi_result/bmi_result_screen.dart';
import 'modules/login/login_screen.dart';
// @dart=2.9
//Mohammad Halaweh99
void main()
{

  //----------------------------------------------------------------------------
  // WidgetsFlutterBinding.ensureInitialized();
  // var bloc;
  // Bloc.observer= MyBlocObserver();
  DioHelper.init();
  // await CacheHelper.init();
  // bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  // final bool isDark;
  // MyApp(this.isDark);
  @override
  Widget build(BuildContext context)
  {
    return  BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context , state){},
        builder:(context , state) {
          return           MaterialApp(
            //To Detect Language------------------------------------------------------
            localizationsDelegates:
            [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:
            [
              // Locale('en', ''), // English, no country code
              Locale('ar', 'AE'), // Arabic, no country code
            ],
            debugShowCheckedModeBanner: false,
            //Theme Data--------------------------------------------------------------
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            // home:LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            //   print(constraints.maxWidth.toInt());
            //
            //   if(constraints.maxWidth.toInt() <= 530)
            //     return MobileScreen();
            //   else
            //     return WebScreen();
            // },),

            home:Builder(
                builder: (BuildContext context)
                    {


                      if(MediaQuery.of(context).size.width.toInt() <=500)
                        return MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: 0.5,
                            ),
                            child: MobileScreen()
                        );
                      else

                        return MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: 2,
                            ),
                            child: WebScreen()
                        );
                    }

            )






        //     home:ScreenTypeLayout(
        //       mobile: NewsLayout(),
        //       desktop:
        //       Text("Website",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20),),
        //       // breakpoints: ScreenBreakpoints(
        //       //   desktop:800 ,
        //       //   tablet: 800,
        //       //   watch: 800,
        //       //
        //       // ),
        //   ),
        //




              // home:OnBoardingScreen(),





          );
        },
      ),
    );
  }
}





