import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/core/entity/entity.dart';
import '../../../logic/core/forms/form_cubit.dart';
import '../errors/bloc_exception_listener.dart';
import '../errors/state_switch.dart';
import '../general/style.dart';

class FormInfo<V extends Value> extends Equatable {
  final V current;
  final void Function(V) update;
  final Widget action;
  final bool isEditing;

  @override
  List get props => [current, update, action, isEditing];
  const FormInfo(this.current, this.update, this.action, this.isEditing);
}

class FormWidget<V extends Value> extends StatelessWidget {
  final FormCubit<V> Function() _cubitFactory;
  final Widget Function(FormInfo<V>) _bodyBuilder;
  const FormWidget({
    required FormCubit<V> Function() cubitFactory,
    required Widget Function(FormInfo<V>) bodyBuilder,
    Key? key,
  })  : _cubitFactory = cubitFactory,
        _bodyBuilder = bodyBuilder,
        super(key: key);

  Widget _buildForm(BuildContext context, FormCubitState<V> state) {
    if (state.val == null) {
      if (state.exception == null) {
        return loadingWidget;
      } else {
        return ExceptionWidget(exception: state.exception!);
      }
    } else {
      return _bodyBuilder(
        FormInfo(
          state.val!,
          context.read<FormCubit<V>>().valueEdited,
          _buildAction(context, state),
          state.isEditing,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubitFactory(),
      child: BlocExceptionListener<FormCubit<V>, FormCubitState<V>>(
        getException: (s) => s.exception,
        child: BlocBuilder<FormCubit<V>, FormCubitState<V>>(
          builder: (context, state) => _buildForm(context, state),
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, FormCubitState<V> state) {
    if (state.isEditing) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: context.read<FormCubit<V>>().cancelPressed,
            child: const Text("Cancel", style: formActionStyle),
          ),
          const SizedBox(width: 5),
          // TODO: show the exception text somewhere
          // if (state.exception != null) Text(state.exception.toString()),
          _getUpdIcon(state.upd),
          ElevatedButton(
            onPressed: state.updateAvailable() ? context.read<FormCubit<V>>().updatePressed : null,
            child: const Text("Update"),
          ),
        ],
      );
    } else {
      return TextButton(
        onPressed: context.read<FormCubit<V>>().editPressed,
        child: const Text(
          "Edit",
          style: formActionStyle,
        ),
      );
    }
  }

  Widget _getUpdIcon(UpdateState upd) {
    switch (upd) {
      case UpdateState.unchanged:
        return Container();
      case UpdateState.editing:
        return Container();
      case UpdateState.updating:
        return const Padding(
          padding: EdgeInsets.only(right: 5),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        );
      case UpdateState.updated:
        return const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(Icons.check, size: 20, color: Colors.green),
        );
    }
  }
}
