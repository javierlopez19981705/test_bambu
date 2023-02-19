part of 'search_cubit.dart';

enum SearchStatus { loading, success, error, loadingMore }

class SearchState {
  const SearchState({
    this.status = SearchStatus.loading,
    this.news = const [],
    this.page = 1,
    this.query,
  });

  final SearchStatus status;
  final List<NewModel> news;
  final int page;
  final String? query;

  SearchState copyWith({
    SearchStatus? status,
    List<NewModel>? news,
    int? page,
    String? query,
  }) {
    return SearchState(
      status: status ?? this.status,
      news: news ?? this.news,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }
}
