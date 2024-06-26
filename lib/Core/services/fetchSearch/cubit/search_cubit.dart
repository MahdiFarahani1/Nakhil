import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Core/services/fetchAll/model/title_news_model.dart';
import 'package:flutter_application_1/Core/services/fetchSearch/cubit/status.dart';
import 'package:flutter_application_1/Core/services/fetchSearch/provider.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(status: InitSearch()));

  initPage() {
    emit(SearchState(status: InitSearch()));
  }

  Future<void> search(
      {required String sw,
      required int sctitle,
      required int sctxt,
      required int categoryID,
      required int start,
      required BuildContext context}) async {
    emit(SearchState(status: LoadingSearch()));
    try {
      var response = await ProviderSearch().fetchData(
          context: context,
          start: start,
          sw: sw,
          sctitle: sctitle,
          sctxt: sctxt,
          categoryID: categoryID);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();

        emit(SearchState(status: ComplateSearch(), news: newsModel));
      }
    } catch (e) {
      print(e);
      emit(SearchState(status: ErrorSearch()));
    }
  }

  void loadMore(
      {required ScrollController controller,
      required int sctitle,
      required int sctxt,
      required String sw,
      required BuildContext context,
      required int categoryID}) async {
    if (state.hasNextPage == true &&
        state.isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRunning: true));

      try {
        state.start += 20;

        var res = await ProviderSearch().fetchData(
            context: context,
            start: state.start,
            sw: sw,
            sctitle: sctitle,
            sctxt: sctxt,
            categoryID: categoryID);

        if (res.statusCode == 200) {
          List<dynamic> newsList = res.data['posts'];
          if (newsList.isEmpty) {
            emit(state.copyWith(hasNextPage: false));
          } else {
            List<NewsGet> newsModel =
                newsList.map((json) => NewsGet.fromJson(json)).toList();
            List<NewsGet> updatedNewsList = List.from(state.news)
              ..addAll(newsModel);

            emit(state.copyWith(news: updatedNewsList));
          }
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      emit(state.copyWith(isLoadMoreRunning: false));
    }
  }
}
