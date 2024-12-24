import 'package:clean_architecture/cors/theme/theme.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:clean_architecture/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_Blogs',
      theme: AppTheme.darkThemeMode,
      home: LoginPage(),
    );
  }
}
