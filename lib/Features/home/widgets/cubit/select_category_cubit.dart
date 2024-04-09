import 'package:bloc/bloc.dart';
import 'package:nakhil/Core/utils/category.dart';

part 'select_category_state.dart';

class SelectCategoryCubit extends Cubit<SelectCategoryState> {
  SelectCategoryCubit()
      : super(SelectCategoryState(
            boolList: List.generate(
                categoryId.length, (index) => index == 0 ? true : false)));

  changeState(int index) {
    List<bool> updatedList = List.generate(
      categoryId.length,
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
