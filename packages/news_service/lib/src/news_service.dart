import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_repository/news_repository.dart';

class NewsService {
  NewsService({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String _baseUrl = 'newsapi.org';
  final _apiKey = '58ffed0701a54ab5b748fd356a48ab0b';

  ///
  Future<List<Map<String, dynamic>>> fetchEverything({
    required String query,
  }) async {
    final parameters = {
      'q': query,
      'apiKey': _apiKey,
    };
    final String _endPoint = 'v2/everything';

    http.Response response;
    List<dynamic> body;

    final uri = Uri.https(_baseUrl, _endPoint, parameters);

    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpRequestException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestException();
    }

    try {
      body = jsonDecode(response.body)['articles'] as List;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return body.map((element) {
        return element as Map<String, dynamic>;
      }).toList();
    } on Exception {
      throw JsonDecodeException();
    }
  }

  Future<List<Map<String, dynamic>>> fetchTopHeadlines({
    required String country,
    CategoryNew? category,
  }) async {
    final String _endPoint = 'v2/top-headlines';
    final parameters = {
      'country': country,
      'apiKey': _apiKey,
    };

    category != null ? parameters.addAll({'category': category.value}) : {};

    http.Response response;
    List<dynamic> body;

    final uri = Uri.https(_baseUrl, _endPoint, parameters);

    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpRequestException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestException();
    }

    try {
      body = jsonDecode(response.body)['articles'] as List;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return body.map((element) {
        return element as Map<String, dynamic>;
      }).toList();
    } on Exception {
      throw JsonDecodeException();
    }
  }

  // https://newsapi.org/v2/everything?q=bitcoin&apiKey=58ffed0701a54ab5b748fd356a48ab0b&pageSize=20&page=2&language=es

  Future<List<Map<String, dynamic>>> fetchSearchNews({
    required String query,
    required int page,
  }) async {
    final pageSize = 20;
    final String _endPoint = 'v2/everything';

    final parameters = {
      'q': query,
      'apiKey': _apiKey,
      'pageSize': pageSize.toString(),
      'page': page.toString(),
      'language': 'es'
    };

    http.Response response;
    List<dynamic> body;

    final uri = Uri.https(_baseUrl, _endPoint, parameters);

    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpRequestException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestException();
    }

    try {
      body = jsonDecode(response.body)['articles'] as List;
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return body.map((element) {
        return element as Map<String, dynamic>;
      }).toList();
    } on Exception {
      throw JsonDecodeException();
    }
  }
}

///
class HttpRequestException implements Exception {}

///
class JsonDecodeException implements Exception {}
