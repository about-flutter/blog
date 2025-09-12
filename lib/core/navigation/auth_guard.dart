import 'package:blog/core/constants/route_constants.dart';
import 'package:blog/core/navigation/navigation_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A guard to protect routes that require authentication
class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: RouteConstants.authModule);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    try {
      // Check if user is authenticated with Supabase
      final session = Supabase.instance.client.auth.currentSession;
      return session != null && !session.isExpired;
    } catch (e) {
      // If there's an error, redirect to auth
      NavigationService.navigateToAuth();
      return false;
    }
  }
}
