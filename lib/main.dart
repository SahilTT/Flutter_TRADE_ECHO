import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/di/injection_container.dart' as di;
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  debugPrint("App starting...");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    debugPrint("Initializing Firebase...");
    await Firebase.initializeApp();
    debugPrint("Firebase initialized.");
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
  debugPrint("Initializing Dependencies...");
  await di.init();
  debugPrint("Dependencies initialized. Running App.");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<AuthBloc>())],
      child: MaterialApp.router(
        title: 'Trade Echo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
