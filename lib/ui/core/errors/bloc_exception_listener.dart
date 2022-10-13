import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di.dart';
import '../../../logic/core/errors/errors.dart';
import 'exception_snackbar.dart';

class BlocExceptionListener<B extends BlocBase<S>, S> extends StatelessWidget {
  final Exception? Function(S) getException;
  final Widget child;
  const BlocExceptionListener({
    Key? key,
    required this.getException,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        final e = getException(state);
        if (e != null) {
          if (e is NetworkException && e.statusCode == 401) {
            uiDeps.auth.refresh();
          } else {
            showExceptionSnackbar(context, e);
          }
        }
      },
      child: child,
    );
  }
}
