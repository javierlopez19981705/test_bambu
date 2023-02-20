import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bambu/src/pages/login/cubit/auth_cubit.dart';
import 'package:test_bambu/src/utils/fonts_styles.dart';
import 'package:test_bambu/src/widgets/custom_image_network.dart';
import 'package:test_bambu/src/widgets/custom_text_form_field.dart';

final _formKey = GlobalKey<FormState>();

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
    this.messageError,
    this.isLogin = false,
  });

  final String? messageError;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _inputEmail(context: context),
                          const SizedBox(height: 8),
                          _inputPassword(context: context),
                          const SizedBox(height: 8),
                          messageError == null
                              ? const SizedBox()
                              : Text('$messageError'),
                          const SizedBox(height: 8),
                          _buttonLoginEmail(context: context),
                          const SizedBox(height: 8),
                          const Text(
                            'O inicia sesion con',
                            style: bodyStyleBold,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AuthCubit>().loginWithGoogle();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CustomImageNetwork(
                                  urlImage:
                                      'https://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 8),
                                Text('Google')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    InkWell(
                      child: const Text(
                        'Registrarse',
                        style: bodyStyleBold,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'register');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
        context.read<AuthCubit>().saveEmail(value: value ?? '');
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
        context.read<AuthCubit>().savePassword(value: value ?? '');
      },
    );
  }

  Widget _buttonLoginEmail({required BuildContext context}) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          context.read<AuthCubit>().login();
        }
      },
      child: isLogin
          ? const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Text('INICIAR SESION'),
    );
  }
}
