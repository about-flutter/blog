import 'package:flutter/material.dart';

/// A simple placeholder widget for Modular router
///
/// This widget is used as the initial route in our navigation system.
/// It doesn't display any UI elements because it's meant to be immediately
/// redirected by AuthGuard based on authentication state.
///
/// When a user navigates to '/', the AuthGuard will check if they're
/// authenticated and redirect them to either '/blog/' or '/auth/'
/// accordingly, so this widget is never actually visible to the user.
class EmptyRouterOutlet extends StatelessWidget {
  const EmptyRouterOutlet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return an empty container since this widget will be
    // immediately redirected by the AuthGuard
    return Container();
  }
}
