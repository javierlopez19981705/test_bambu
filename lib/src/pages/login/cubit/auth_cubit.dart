import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService authService;

  AuthCubit({required this.authService})
      : super(
          authService.currentUser.isNotEmpty
              ? AuthState.authenticated(authService.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    authService.user.listen((user) {
      _onUserChanged(user);
    });
  }

  void _onUserChanged(UserModel user) {
    emit(user.isEmpty
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(user));
  }

  register({required String email, required String password}) {
    authService.signUp(email: email, password: password);
  }

  login({required String email, required String password}) {
    authService.loginWithEmailAndPassword(email: email, password: password);
  }

  loginWithGoogle() {
    authService.loginWithGoogle();
  }

  logout() {
    authService.logOut();
  }
}
