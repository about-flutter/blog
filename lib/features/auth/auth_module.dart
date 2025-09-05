import 'package:blog/features/auth/presentation/view/login_screen.dart';
import 'package:blog/features/auth/presentation/view/signup_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {}
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => LoginScreen(),
    transition: TransitionType.fadeIn,);
    r.child('/signup', child: (context) => SignUpScreen(),
     transition: TransitionType.rightToLeft,
     );
  }
}
