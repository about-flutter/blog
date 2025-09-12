import 'package:blog/core/constants/route_constants.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// A service to centralize navigation logic and provide a cleaner API
/// for navigating between screens
class NavigationService {
  /// Navigate to the auth module
  static void navigateToAuth() =>
      Modular.to.navigate(RouteConstants.authModule);

  /// Navigate to the auth signup screen
  static void navigateToSignup() => Modular.to.navigate(
    '${RouteConstants.authModule}${RouteConstants.signUp}',
  );

  /// Navigate to the blog module
  static void navigateToBlog() =>
      Modular.to.navigate(RouteConstants.blogModule);

  /// Navigate to add new blog screen
  static void navigateToAddBlog() => Modular.to.navigate(
    '${RouteConstants.blogModule}${RouteConstants.addBlog}',
  );

  /// Navigate to blog detail screen with a blog object
  static void navigateToBlogDetail(dynamic blog) => Modular.to.navigate(
    '${RouteConstants.blogModule}${RouteConstants.blogDetail}',
    arguments: blog,
  );

  /// Navigate to user profile screen
  static void navigateToProfile() => Modular.to.navigate(
    '${RouteConstants.blogModule}${RouteConstants.profile}',
  );

  /// Go back to previous screen
  static void goBack() => Modular.to.pop();

  /// Navigate to home and clear navigation stack
  static void navigateToHome() {
    // Navigate to the root and clear stack
    Modular.to.navigate('/');
    Modular.to.navigate(RouteConstants.authModule);
  }
}
