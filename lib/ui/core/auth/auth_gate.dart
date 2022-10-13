import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../logic/core/auth/auth_facade.dart';
import '../app/home_screen.dart';
import '../app/splash_screen.dart';
import 'auth_screen.dart';

class AuthGate extends StatelessWidget {
  final Stream<Option<AuthToken>> _authStream;

  AuthGate({Key? key})
      : _authStream = uiDeps.auth.getTokenStream(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Option<AuthToken>>(
      stream: _authStream,
      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data!.fold(
              () => const AuthScreen(),
              (_) => const HomeScreen(),
            )
          : const SplashScreen(),
    );
  }
}
