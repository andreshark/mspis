import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspis/features/presentation/bloc/auth/auth_bloc.dart';
import 'core/app_bloc_observer.dart';
import 'features/presentation/bloc/local_data/local_data_bloc.dart';
import 'features/presentation/pages/curse_lec.dart';
import 'features/presentation/pages/home_page.dart';
import 'features/presentation/pages/login_page.dart';
import 'injection_container.dart';

void main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initializeDependencies();

      return runApp(MultiBlocProvider(providers: [
        BlocProvider<LocalDataBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl(),
        ),
      ], child: const MyApp()));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 233, 228, 228),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      title: 'mispis',
      debugShowCheckedModeBanner: false,
      home: (AuthPage()),
    );
  }
}
