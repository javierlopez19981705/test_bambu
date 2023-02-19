import 'package:news_repository/news_repository.dart';

void main() async {
  NewsRepository repo = NewsRepository();
  final data = await repo.searchNews(page: 1, query: 'bitcoin');
  data.forEach((element) {
    print(element.title);
  });
}
