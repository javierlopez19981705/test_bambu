part of 'register_cubit.dart';

class RegisterState {
  const RegisterState({
    this.success = false,
    this.messageError = '',
  });
  final bool success;
  final String messageError;

  RegisterState copyWith({
    bool? success,
    String? messageError,
  }) =>
      RegisterState(
        success: success ?? this.success,
        messageError: messageError ?? this.messageError,
      );
}
