import 'package:bloc/bloc.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authService}) : super(const RegisterState());

  final FirebaseAuthService authService;

  String name = '';
  String email = '';
  String password = '';

  saveName({required String value}) {
    name = value;
  }

  saveEmail({required String value}) {
    email = value;
  }

  savePassword({required String value}) {
    password = value;
  }

  registerNewUser() async {
    final resp =
        await authService.signUp(email: email, password: password, name: name);
    if (resp == null) {
      emit(
        state.copyWith(success: true),
      );
    } else {
      emit(
        state.copyWith(success: false, messageError: resp),
      );
    }
  }
}
