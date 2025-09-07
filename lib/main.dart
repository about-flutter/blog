import 'package:blog/app_module.dart';
import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/secrets/app_secret.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if user is already logged in
      Modular.get<auth.AuthBloc>().add(auth.AuthIsUserLoggedIn());
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Modular.get<auth.AuthBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (_) => AppUserCubit(authBloc)),
      ],
      child: BlocListener<AppUserCubit, AppUserState>(
        listenWhen: (previous, current) =>
            previous != current, // Chỉ lắng nghe khi trạng thái thay đổi
        listener: (context, state) {
          // Listen for authentication state changes and navigate accordingly
          if (state is AppUserLoggedIn) {
            Modular.to.navigate('/blog/');
          } else if (state is AppUserInitial) {
            Modular.to.navigate('/auth/');
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Blog App',
          theme: AppTheme.darkThemeMode,
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        ),
      ),
    );
  }
}
