import 'package:news_repository/news_repository.dart';

enum HomeStatus { loading, success, error, loadingCategory }

class HomeState {
  const HomeState({
    this.news = const [],
    this.newsHeader = const [],
    this.status = HomeStatus.loading,
  });

  final HomeStatus status;
  final List<NewModel> news;
  final List<NewModel> newsHeader;

  copyWith({
    HomeStatus? status,
    List<NewModel>? news,
    List<NewModel>? newsHeader,
  }) {
    return HomeState(
      news: news ?? this.news,
      status: status ?? this.status,
      newsHeader: newsHeader ?? this.newsHeader,
    );
  }
}
