// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseAuthService', () {
    test('can be instantiated', () {
      expect(FirebaseAuthService(), isNotNull);
    });
  });
}
