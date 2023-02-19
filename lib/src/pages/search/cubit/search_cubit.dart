import 'package:bloc/bloc.dart';
import 'package:news_repository/news_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.repository}) : super(const SearchState());

  final NewsRepository repository;

  initSearch({required String query}) async {
    try {
      final data = await repository.searchNews(query: query, page: state.page);
      emit(state.copyWith(
        status: SearchStatus.success,
        news: data,
        query: query,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: SearchStatus.error,
      ));
    }
  }

  loadMoreNews() async {
    if (state.status != SearchStatus.loadingMore) {
      emit(state.copyWith(
        status: SearchStatus.loadingMore,
        page: state.page + 1,
      ));
      try {
        final data = await repository.searchNews(
          query: state.query!,
          page: state.page,
        );
        emit(state.copyWith(
          status: SearchStatus.success,
          news: [...state.news, ...data],
        ));
      } catch (_) {
        emit(state.copyWith(
          status: SearchStatus.success,
        ));
      }
    }
  }
}
