// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:news_service/news_service.dart';

void main() {
  group('NewsService', () {
    test('can be instantiated', () {
      expect(NewsService(), isNotNull);
    });
  });
}
