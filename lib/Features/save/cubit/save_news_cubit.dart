import 'package:bloc/bloc.dart';
import 'package:nakhil/Core/dataBase/model.dart';
import 'package:nakhil/main.dart';

part 'save_news_state.dart';

class SaveNewsCubit extends Cubit<SaveNewsState> {
  SaveNewsCubit()
      : super(SaveNewsState(
            savedItem: box.values.toList() as List<ItemDatabase>));

  loadSave(int index) async {
    List data = box.values.toList();
    emit(SaveNewsState(savedItem: data as List<ItemDatabase>));
  }
}
