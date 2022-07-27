import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {


    return BlocConsumer<NewsCubit,NewsStates>
      (
      listener: (context,state){},
      builder: (context,state)
      {
        var list = NewsCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: articleBuilder(list,context),
          desktop: Row(children: [
            Expanded(
              child: Container(width: 500,
              child: articleBuilder(list,context),),
            ),
            Expanded(child: Container(color: Colors.red,))
          ],),
             );
      },


    );

  }
}
