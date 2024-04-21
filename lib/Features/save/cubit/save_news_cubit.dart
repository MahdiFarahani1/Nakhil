import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/dataBase/model.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'save_news_state.dart';

class SaveNewsCubit extends Cubit<SaveNewsState> {
  SaveNewsCubit()
      : super(SaveNewsState(
            savedItem: box.values.toList() as List<ItemDatabase>));

  loadSave(BuildContext context) async {
    List data = BlocProvider.of<ControllerApp>(context).state.status is Araghi
        ? box.values.where((element) => element.tag == "a").toList()
        : box.values.where((element) => element.tag == "n").toList();

    emit(SaveNewsState(savedItem: data as List<ItemDatabase>));
  }
}
