import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_bambu/src/pages/app/view/app_view.dart';
import 'package:test_bambu/src/pages/login/cubit/auth_cubit.dart';
import 'package:test_bambu/src/utils/custom_colors.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: createMaterialColor(primaryColor)
          .shade800, //or set color with: Color(0xFF0000FF)
    ));
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FirebaseAuthService(
            auth: FirebaseAuth.instance,
            database: FirebaseDatabase.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => NewsRepository(),
        ),
      ],
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(
          authService: context.read<FirebaseAuthService>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: createMaterialColor(primaryColor),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: primaryColor,
              secondary: const Color.fromRGBO(0, 35, 74, 1),
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextStyle(color: secondaryColor),
              titleTextStyle: TextStyle(color: secondaryColor),
              foregroundColor: secondaryColor,
              elevation: 0,
            ),
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
