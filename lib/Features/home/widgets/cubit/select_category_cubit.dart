import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/category.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_category_state.dart';

class SelectCategoryCubit extends Cubit<SelectCategoryState> {
  SelectCategoryCubit()
      : super(SelectCategoryState(
            boolList: List.generate(
                categoryIdNews.length, (index) => index == 0 ? true : false)));

  initState(BuildContext context) {
    emit(state.copyWith(
        boolList: List.generate(
            (BlocProvider.of<ControllerApp>(context).state.status is Nnews
                ? categoryIdNews.length
                : categoryIdAraghi.length),
            (index) => index == 0 ? true : false)));
  }

  changeState(int index, BuildContext context) {
    List<bool> updatedList = List.generate(
      (BlocProvider.of<ControllerApp>(context).state.status is Nnews
          ? categoryIdNews.length
          : categoryIdAraghi.length),
      (i) => (i == index),
    );
    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = (i == index);
    }

    state.boolList.clear();
    List<bool> list = [...updatedList];
    emit(state.copyWith(boolList: list));
  }

  changeCatId(int catID) {
    emit(state.copyWith(catId: catID));
  }
}
