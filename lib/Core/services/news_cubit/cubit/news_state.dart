part of 'news_cubit.dart';

class NewsState {
  final StatusTitleNews status;
  List<NewsGet>? data;

  int loadMoreCount;

  bool hasNextPage;
  bool isLoadMoreRunning;

  NewsState(
      {required this.status,
      this.data,
      this.loadMoreCount = 0,
      this.hasNextPage = true,
      this.isLoadMoreRunning = false});

  NewsState copyWith({
    StatusTitleNews? status,
    List<NewsGet>? data,
    int? loadMoreCount,
    bool? hasNextPage,
    bool? isLoadMoreRunning,
  }) {
    return NewsState(
        status: status ?? this.status,
        data: data ?? this.data,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        isLoadMoreRunning: isLoadMoreRunning ?? this.isLoadMoreRunning,
        loadMoreCount: loadMoreCount ?? this.loadMoreCount);
  }
}
