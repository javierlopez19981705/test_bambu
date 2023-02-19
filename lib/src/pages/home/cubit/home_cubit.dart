import 'package:bloc/bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/pages/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.newsRepository}) : super(const HomeState());

  final NewsRepository newsRepository;

  getNews() async {
    try {
      final news = await newsRepository.getTopHeadlines();
      emit(state.copyWith(
        news: news,
        newsHeader: news,
        status: HomeStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: HomeStatus.error,
      ));
    }
  }

  getNewsCategory({required CategoryNew category}) async {
    emit(state.copyWith(
      status: HomeStatus.loadingCategory,
    ));
    try {
      final news = await newsRepository.getTopHeadlines(category: category);
      emit(state.copyWith(
        news: news,
        status: HomeStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: HomeStatus.error,
      ));
    }
  }
}
