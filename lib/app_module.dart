import 'package:blog/features/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {}
  @override
  void routes(RouteManager r) {
  r.redirect('/', to: '/auth/'); 
  r.module('/auth', module: AuthModule());

  }
}
