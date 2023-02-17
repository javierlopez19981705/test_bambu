import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bambu/src/pages/login/cubit/auth_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(
                          email: 'javierlopez19981705@gmail.com',
                          password: '12345678',
                        );
                  },
                  child: const Text('LOGIN'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().loginWithGoogle();
                  },
                  child: const Text('Google'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
