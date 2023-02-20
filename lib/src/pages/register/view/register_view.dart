import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bambu/src/pages/register/cubit/register_cubit.dart';

import '../../../widgets/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) =>
            RegisterCubit(authService: context.read<FirebaseAuthService>()),
        child: _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  _RegisterView();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.success == true) {
          Navigator.pop(context);
        } else {
          final snackBar = SnackBar(
            content: Text(state.messageError),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _inputName(context: context),
              const SizedBox(height: 8),
              _inputEmail(context: context),
              const SizedBox(height: 8),
              _inputPassword(context: context),
              const SizedBox(height: 8),
              _buttonLoginEmail(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputName({required BuildContext context}) {
    return CustomTextFormField(
      label: 'Nombre',
      placeholder: 'Escribe tu nombre',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final data = value?.trim() ?? '';
        if (data.isEmpty) {
          return 'El nombre es obligatorio';
        }
        return null;
      },
      onSaved: (value) {
        context.read<RegisterCubit>().saveName(value: value ?? '');
      },
    );
  }

  Widget _inputEmail({required BuildContext context}) {
    return CustomTextFormField(
      label: 'Email',
      placeholder: 'Escribe tu email',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final data = value?.trim() ?? '';
        if (data.isEmpty) {
          return 'El email es obligatorio';
        }
        return null;
      },
      onSaved: (value) {
        context.read<RegisterCubit>().saveEmail(value: value ?? '');
      },
    );
  }

  Widget _inputPassword({required BuildContext context}) {
    return CustomTextFormField(
      label: 'Contraseña',
      placeholder: 'Escribe tu contraseña',
      obscureText: true,
      validator: (value) {
        final data = value?.trim() ?? '';
        if (data.isEmpty) {
          return 'La contraseña es obligatoria';
        } else if (data.length < 6) {
          return 'La contraseña es muy corta';
        }
        return null;
      },
      onSaved: (value) {
        context.read<RegisterCubit>().savePassword(value: value ?? '');
      },
    );
  }

  Widget _buttonLoginEmail({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          context.read<RegisterCubit>().registerNewUser();
        }
      },
      child: const Text('REGISTRARSE'),
    );
  }
}
