import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseRepository {
  FirebaseDatabaseRepository({
    FirebaseDatabase? database,
  }) : _database = database ?? FirebaseDatabase.instance;

  final FirebaseDatabase _database;

  getUser({required UserModel user}) async {
    final ref = _database.ref('users/${user.uid}');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      snapshot.value;
    } else {
      final data = createUser(user: user);
      return data;
    }
  }

  Future<UserModel> createUser({required UserModel user}) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final ref = _database.ref('users/${user.uid}');
    return ref.set(user.toJson()).then((value) {
      return user.copyWith(
        date: DateTime.fromMillisecondsSinceEpoch(time),
      );
    });
  }
}
