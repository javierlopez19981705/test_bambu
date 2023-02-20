part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated, loading, errorLogin, isLogin }

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = UserModel.empty,
    this.error,
  });
  final UserModel user;
  final AuthStatus status;
  final String? error;

  const AuthState.init()
      : this._(
          status: AuthStatus.loading,
        );

  const AuthState.authenticated(UserModel user)
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  const AuthState.errorLogin(String error)
      : this._(status: AuthStatus.errorLogin, error: error);

  const AuthState.login() : this._(status: AuthStatus.isLogin);

  @override
  List<Object?> get props => [user, status];
}
