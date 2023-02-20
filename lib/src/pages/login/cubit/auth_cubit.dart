import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService authService;

  String email = '';
  String pass = '';

  AuthCubit({required this.authService}) : super(const AuthState.init()) {
    authService.user.listen((user) {
      _onUserChanged(user);
    });
  }

  void _onUserChanged(UserModel user) {
    emit(user.isEmpty
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(user));
  }

  saveEmail({required String value}) {
    email = value;
  }

  savePassword({required String value}) {
    pass = value;
  }

  login() async {
    emit(const AuthState.login());

    final resp = await authService.loginWithEmailAndPassword(
        email: email, password: pass);
    if (resp != null) {
      emit(AuthState.errorLogin(resp));
    }
  }

  loginWithGoogle() {
    authService.loginWithGoogle();
  }

  logout() {
    authService.logOut();
  }
}
