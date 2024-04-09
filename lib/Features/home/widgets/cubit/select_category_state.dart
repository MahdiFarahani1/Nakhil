part of 'select_category_cubit.dart';

class SelectCategoryState {
  List<bool> boolList;

  int selectIndex;
  int catId;
  SelectCategoryState(
      {this.selectIndex = 0, required this.boolList, this.catId = 0});
  SelectCategoryState copyWith(
      {List<bool>? boolList, int? selectIndex, int? catId}) {
    return SelectCategoryState(
        boolList: boolList ?? this.boolList,
        selectIndex: selectIndex ?? this.selectIndex,
        catId: catId ?? this.catId);
  }
}
