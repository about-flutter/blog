import 'package:blog/app_module.dart';
import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/constants/route_constants.dart';
import 'package:blog/core/secrets/app_secret.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart' as auth;
import 'package:blog/features/blog/data/adapters/blog_model_adapter.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Hive adapters
  Hive.registerAdapter(BlogModelAdapter());

  // Open Box for blog
  await Hive.openBox('blogBox');

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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: Modular.get<auth.AuthBloc>()),
        BlocProvider.value(value: Modular.get<AppUserCubit>()),
      ],
      child: BlocListener<AppUserCubit, AppUserState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is AppUserLoggedIn) {
            Modular.to.navigate(RouteConstants.blogModule);
          } else if (state is AppUserInitial) {
            Modular.to.navigate(RouteConstants.authModule);
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
