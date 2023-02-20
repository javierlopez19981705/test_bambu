import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_service/src/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
class FirebaseAuthService {
  ///
  FirebaseAuthService({
    firebase_auth.FirebaseAuth? auth,
    FirebaseDatabase? database,
  })  : _auth = auth ?? firebase_auth.FirebaseAuth.instance,
        _database = database ?? FirebaseDatabase.instance;

  firebase_auth.FirebaseAuth _auth;
  var currentUser = UserModel.empty;
  final FirebaseDatabase _database;

  Stream<UserModel> get user {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      var user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;

      if (user.isNotEmpty) {
        user = await getUserDatabase(user: user);
      }

      currentUser = user;
      return user;
    });
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUserDatabase(
        user: UserModel(
          uid: _auth.currentUser!.uid,
          name: name,
          email: _auth.currentUser!.email,
        ),
      );
      logOut();
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<String?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        GoogleSignIn().signOut(),
      ]);
    } catch (_) {}
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserModel> getUserDatabase({required UserModel user}) async {
    final ref = _database.ref('users/${user.uid}');

    final snapshot = await ref.get();
    if (snapshot.exists) {
      snapshot.value;
      print('EXISTE');
      // snapshot.valu
      return UserModel.fromJson(snapshot.value as Map<Object?, dynamic>);
    } else {
      print('NO EXISTE');
      return await createUserDatabase(user: user);
    }
  }

  Future<UserModel> createUserDatabase({required UserModel user}) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final ref = _database.ref('users/${user.uid}');

    final data = <String, dynamic>{"date": time, "uid": user.uid};

    user.email != null ? data.addAll({"email": user.email}) : {};
    user.name != null ? data.addAll({"name": user.name}) : {};
    user.photo != null ? data.addAll({"photo": user.photo}) : {};

    return ref.update(data).then((value) {
      return user.copyWith(
        date: DateTime.fromMillisecondsSinceEpoch(time),
      );
    }).catchError((error) {
      print(error);
      return UserModel.empty;
    });
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
      uid: uid,
      email: email,
      name: displayName,
      photo: photoURL,
    );
  }
}
