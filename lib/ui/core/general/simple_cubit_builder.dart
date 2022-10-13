import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/core/errors/bloc_state.dart';
import '../../../logic/core/simple_cubit.dart';
import '../errors/bloc_exception_listener.dart';
import '../errors/state_switch.dart';

class SimpleCubitBuilder<V extends Equatable> extends StatelessWidget {
  final Future<Either<Exception, V>> Function() load;
  final Widget Function(V, SimpleCubit<V>) loadedBuilder;
  const SimpleCubitBuilder({
    Key? key,
    required this.load,
    required this.loadedBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SimpleCubit<V>>(
      create: (_) => SimpleCubit<V>(load),
      child: BlocExceptionListener<SimpleCubit<V>, BlocState<V>>(
        getException: (s) => s.getException(),
        child: BlocBuilder<SimpleCubit<V>, BlocState<V>>(
          builder: (context, state) => stateSwitch<V>(
            state: state,
            loadedBuilder: (v) => loadedBuilder(v, context.read<SimpleCubit<V>>()),
          ),
        ),
      ),
    );
  }
}
