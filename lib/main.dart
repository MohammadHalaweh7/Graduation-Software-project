import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/modules/admin/admin_main_web_screen.dart';
import 'package:udemy_flutter/modules/home/home_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'package:udemy_flutter/translations.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:udemy_flutter/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

// @dart=2.9
//Mohammad Halaweh99

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //  options: const FirebaseOptions(
  //    apiKey:"AAAA1-uKg5g:APA91bGbOCRD5CsqtzDADIVk35DlYMVKMwK-VqcJ7bAbXassPWok45rFdRkWH7kk2TYo_ogERYfUUTkBsHwcBuBsBy4evMbmniLQr7TRlK4XpA_glaqvUivQdl9wWrUpeZjceIRCIz4k" ,
  //    appId: "1:927369692056:ios:ed7abdcb63a1e1133761ed",
  //    messagingSenderId:"927369692056	" ,
  //    projectId:"udemy-flutter-184b4" ,
  //  ),
  // );


  await Firebase.initializeApp();
  runApp(MyApp());
  prefs = await SharedPreferences.getInstance();

  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);
  //
  // FirebaseMessaging.onMessage.listen((event)
  // {
  //   print('on oppenning app');
  //   print(event.data.toString());
  //
  //   // showToast(text:'on massage',state: ToastStates.SUCCESS);
  // });
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event)
  // {
  //   print(event.data.toString());
  //   // showToast(text:'onMessageOpenedApp',state: ToastStates.SUCCESS);
  // });

  //----------------------------------------------------------------------------
  // WidgetsFlutterBinding.ensureInitialized();
  // var bloc;
  // Bloc.observer= MyBlocObserver();
  DioHelper.init();
  // await CacheHelper.init();
  // bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  // MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            translations: Translation(),
            locale: Locale('ar'),
            fallbackLocale: Locale('ar'),
            debugShowCheckedModeBanner: false,
            //To Detect Language------------------------------------------------------

            // localizationsDelegates: const [
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: const [
            //   // Locale('en', ''), // English, no country code
            //   Locale('ar', 'AE'), // Arabic, no country code
            // ],
            // debugShowCheckedModeBanner: false,

            //Theme Data--------------------------------------------------------------
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

            home: FutureBuilder(
              future: hasToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return MainScreen();
                  } else {
                    return OnBoardingScreen();
                  }
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }

  hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    return token != null;
  }
}
