import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/modules/home/home_screen.dart';
import 'package:udemy_flutter/modules/home/main_screen.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';

// @dart=2.9
//Mohammad Halaweh99
void main() {
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
          return MaterialApp(
            //To Detect Language------------------------------------------------------
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              // Locale('en', ''), // English, no country code
              Locale('ar', 'AE'), // Arabic, no country code
            ],
            debugShowCheckedModeBanner: false,
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
