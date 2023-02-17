import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bambu/src/pages/home/view/home_view.dart';
import 'package:test_bambu/src/pages/login/view/login_view.dart';

import '../../login/cubit/auth_cubit.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                return HomeView();
              case AuthStatus.unauthenticated:
                return const LoginView();
            }
          },
        ),
      ),
    );
  }
}
