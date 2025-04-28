import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/Auth/auth_state.dart';
import '../bloc/Auth/auth_bloc.dart';

class AuthNavigatorObserver extends NavigatorObserver {
  StreamSubscription<AuthState>? _authSubscription;
  BuildContext? _currentContext;
  bool _isDialogShowing = false;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    print('AuthNavigatorObserver: Route pushed: ${route.settings.name}');
    _updateSubscription(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    print('AuthNavigatorObserver: Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
    _updateSubscription(newRoute);
  }

  void _updateSubscription(Route? route) {
    if (route?.navigator != null) {
      final newContext = route!.navigator!.context;
      if (_currentContext != newContext || _authSubscription == null) {
        print('AuthNavigatorObserver: Context changed or no subscription, updating to: $newContext');
        _currentContext = newContext;
        _authSubscription?.cancel();
        _listenToAuthState(_currentContext!);
      }
    }
  }

  void _listenToAuthState(BuildContext context) {
    print('AuthNavigatorObserver: Subscribing to AuthBloc with context: $context');
    try {
      final authBloc = context.read<AuthBloc>();
      print('AuthNavigatorObserver: Current AuthBloc state: ${authBloc.state}');
      _authSubscription = authBloc.stream.listen((state) {
        print('AuthNavigatorObserver: AuthBloc state changed to $state');
        if (state is AuthUnauthenticated && state.message != null && !_isDialogShowing) {
          print('AuthNavigatorObserver: Showing session expired dialog with message: ${state.message}');
          _isDialogShowing = true;
          _showSessionExpiredDialog(context, state.message!);
        }
      }, onError: (error) {
        print('AuthNavigatorObserver: Stream error: $error');
      }, onDone: () {
        print('AuthNavigatorObserver: Stream done');
      });
    } catch (e) {
      print('AuthNavigatorObserver: Failed to subscribe to AuthBloc: $e');
    }
  }

  void _showSessionExpiredDialog(BuildContext context, String message) {
    print('AuthNavigatorObserver: Attempting to show dialog in context: $context');
    try {
      if (!context.mounted) {
        print('AuthNavigatorObserver: Context not mounted, cannot show dialog');
        _isDialogShowing = false;
        return;
      }
      Get.dialog(
        AlertDialog(
          title: const Text('Session Expired'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                print('AuthNavigatorObserver: Dialog OK pressed, navigating to /login');
                _isDialogShowing = false;
                Get.back();
                Get.offAllNamed('/login');
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      ).then((_) {
        print('AuthNavigatorObserver: Dialog closed');
        _isDialogShowing = false;
      }).catchError((error) {
        print('AuthNavigatorObserver: Dialog error: $error');
        _isDialogShowing = false;
      });
    } catch (e) {
      print('AuthNavigatorObserver: Failed to show dialog: $e');
      _isDialogShowing = false;
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('AuthNavigatorObserver: Route popped: ${route.settings.name}');
    _updateSubscription(previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    print('AuthNavigatorObserver: Route removed: ${route.settings.name}');
    _updateSubscription(previousRoute);
  }

  @override
  void dispose() {
    print('AuthNavigatorObserver: Disposing, cancelling subscription');
    _authSubscription?.cancel();
    _authSubscription = null;
    _currentContext = null;

  }
}