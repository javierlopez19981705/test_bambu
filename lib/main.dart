import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bambu/src/pages/app/view/app_view.dart';
import 'package:test_bambu/src/pages/login/cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthService(
        auth: FirebaseAuth.instance,
        database: FirebaseDatabase.instance,
      ),
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(
          authService: context.read<FirebaseAuthService>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          routes: {
            'app': (context) => const AppView(),
          },
          initialRoute: 'app',
        ),
      ),
    );
  }
}
