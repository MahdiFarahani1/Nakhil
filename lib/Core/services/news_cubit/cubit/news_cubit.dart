import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Core/services/fetchAll/model/title_news_model.dart';
import 'package:flutter_application_1/Core/services/news_cubit/cubit/status.dart';
import 'package:flutter_application_1/Core/services/provider_all.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState(status: LoadingA()));

  fetchData(
      {required int start,
      required int limit,
      required int catId,
      bool isArt = false,
      required BuildContext context}) async {
    emit(NewsState(status: LoadingA()));
    try {
      var response = !isArt
          ? await ProviderAll().fetchAllData(
              context: context,
              categoryid: catId,
              start: start,
            )
          : await ProviderAll().fetchArtData(context: context, start: start);

      if (response.statusCode == 200) {
        List<dynamic> newsList = response.data['posts'];
        List<NewsGet> newsModel =
            newsList.map((json) => NewsGet.fromJson(json)).toList();

        emit(NewsState(status: CompleteA(), data: newsModel));
      } else {
        emit(NewsState(status: ErrorA()));
      }
    } catch (e) {
      print(e);
      emit(NewsState(status: ErrorA()));
    }
  }

  loadMore(ScrollController controller, int catid, BuildContext context,
      {bool isArt = false}) async {
    if (state.hasNextPage == true &&
        state.isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      emit(state.copyWith(isLoadMoreRunning: true));
      numberCat += 20;
      state.loadMoreCount += numberCat;

      try {
        var response = !isArt
            ? await ProviderAll().fetchAllData(
                start: state.loadMoreCount, categoryid: catid, context: context)
            : await ProviderAll()
                .fetchArtData(context: context, start: state.loadMoreCount);

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

int numberCat = 0;
