import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nakhil/Core/services/fetchAll/model/title_news_model.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/status.dart';
import 'package:nakhil/Core/services/provider_all.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState(status: LoadingA()));

  fetchData({required int start, required int limit}) async {
    try {
      var response = await ProviderAll().fetchAllData(
        start: start,
      );

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();

        emit(NewsState(status: CompleteA(), data: newsModel));
      } else {
        emit(NewsState(status: ErrorA()));
      }
    } catch (e) {
      emit(NewsState(status: ErrorA()));
    }
  }

  loadMore(ScrollController controller) async {
    if (state.hasNextPage == true &&
        state.isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRunning: true));
      try {
        state.loadMoreCount += 20;
        var response = await ProviderAll().fetchAllData(
          start: state.loadMoreCount,
        );

        if (response.statusCode == 200) {
          List<dynamic> newsList = response.data['posts'];
          List<NewsGet> newsModel =
              newsList.map((json) => NewsGet.fromJson(json)).toList();
          List<NewsGet> updatedNewsList = List.from(state.data!)
            ..addAll(newsModel);
          emit(NewsState(status: CompleteA(), data: updatedNewsList));
        } else {
          emit(NewsState(status: ErrorA()));
        }
      } catch (e) {
        emit(NewsState(status: ErrorA()));
      }
      emit(state.copyWith(isLoadMoreRunning: false));
    }
  }
}
