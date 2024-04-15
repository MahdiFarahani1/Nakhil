import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhil/Core/utils/category.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:nakhil/Features/home/widgets/category/category-item.dart';

class Cat {
  Widget category(
      BuildContext context, int selectedIndex, List<bool> boolList) {
    return StatefulBuilder(builder: (context, setstate) {
      setstate(
        () {
          setstate(
            () {
              boolList;
            },
          );
        },
      );
      return SizedBox(
        width: EsaySize.width(context),
        height: 40,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CatItem(
              mapCat:
                  (BlocProvider.of<ControllerApp>(context).state.status is Nnews
                      ? categoryIdNews
                      : categoryIdAraghi),
              index: index,
              boolList: boolList,
            );
          },
          itemCount:
              (BlocProvider.of<ControllerApp>(context).state.status is Nnews
                  ? categoryIdNews.length
                  : categoryIdAraghi.length),
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }
}
