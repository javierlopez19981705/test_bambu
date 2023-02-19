import 'package:news_repository/news_repository.dart';
import 'package:news_service/news_service.dart';

class NewsRepository {
  NewsRepository({
    NewsService? newsService,
  }) : _newsService = newsService ?? NewsService();

  final NewsService _newsService;

  Future<List<NewModel>> searchNews({
    required String query,
    required int page,
  }) async {
    final data = await _newsService.fetchSearchNews(query: query, page: page);
    try {
      final news = data.map(NewModel.fromJson).toList();

      return news;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<NewModel>> getTopHeadlines({
    String country = 'mx',
    CategoryNew? category,
  }) async {
    try {
      final data = await _newsService.fetchTopHeadlines(
        category: category,
        country: country,
      );
      final news = data.map(NewModel.fromJson).toList();

      return news;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
