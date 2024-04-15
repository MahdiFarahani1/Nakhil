import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nakhil/Core/services/fetchContentApi/model/content_model.dart';
import 'package:nakhil/Core/services/provider_all.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentState(status: ClickLoading()));

  fetchData({required int id, required BuildContext context}) async {
    emit(ContentState(status: ClickLoading()));
    try {
      var response = !Art.isAretMode
          ? await ProviderAll().fetchClickData(id: id, context: context)
          : await ProviderAll().fetchArtClickData(id: id, context: context);
      if (response.statusCode == 200) {
        var newsModel = ContentModel.fromJson(response.data);
        emit(ContentState(status: ClickComplete(), data: newsModel));
      } else {
        emit(ContentState(
          status: ClickError(),
        ));
      }
    } catch (e) {
      print(e);
      emit(ContentState(
        status: ClickError(),
      ));
    }
  }
}

class Art {
  static bool isAretMode = false;
}
