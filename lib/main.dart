import 'package:clean_architecture/cors/common/widgets/cubits/app_user_cubit.dart';
import 'package:clean_architecture/cors/theme/theme.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:clean_architecture/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:clean_architecture/features/blogs/presentation/pages/blog_page.dart';
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
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
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
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_Blogs',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
         return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {

          if(isLoggedIn){
            return BlogPage();
          }

          return LoginPage();
        },
      ),
    );
  }
}
