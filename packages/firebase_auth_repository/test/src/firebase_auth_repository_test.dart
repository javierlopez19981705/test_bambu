// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseAuthRepository', () {
    test('can be instantiated', () {
      expect(FirebaseAuthRepository(), isNotNull);
    });
  });
}
