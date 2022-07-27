// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
// import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
// import 'package:udemy_flutter/shared/components/components.dart';
//
// class NewsSearchScreen extends StatelessWidget
// {
//   var searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return BlocConsumer<NewsCubit, NewsStates>(
//       listener: (context, state) {},
//       builder: (context, state)
//       {
//         var list = NewsCubit.get(context).search;
//
//         return Scaffold(
//           appBar: AppBar(),
//           body: Column(
//             children:
//             [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child:
//
//                 TextFormField(
//                   controller: searchController,
//                   keyboardType:  TextInputType.text,
//
//                   decoration: InputDecoration(
//                     labelText: 'Search',
//                     prefixIcon: Icon(
//                       Icons.search,
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               Expanded(child: articleBuilder(list, context)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }