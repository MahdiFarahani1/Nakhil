import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:nakhil/Features/home/widgets/cubit/select_category_cubit.dart';

// ignore: must_be_immutable
class CatItem extends StatelessWidget {
  final Map mapCat;
  final int index;
  List<bool> boolList;

  CatItem(
      {super.key,
      required this.mapCat,
      required this.index,
      required this.boolList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<SelectCategoryCubit>(context).changeState(index);
          int categoryId = mapCat.keys.toList()[index];
          BlocProvider.of<SelectCategoryCubit>(context).changeCatId(categoryId);
          BlocProvider.of<NewsCubit>(context)
              .fetchData(start: 0, limit: 20, catId: categoryId);
          numberCat = 0;
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: boolList[index]
                ? ConstColor.baseColor
                : ConstColor.itemBackground,
            elevation: 0),
        child: Text(
          mapCat.values.elementAt(index),
          style: TextStyle(
              color: boolList[index] ? Colors.white : ConstColor.baseColor),
        ),
      ),
    );
  }
}
