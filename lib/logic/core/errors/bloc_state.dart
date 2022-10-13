import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

typedef BlocState<S extends Equatable> = Option<Either<Exception, S>>;

extension BlocStateExceptionGetter on BlocState {
  Exception? getException() => fold(
        () => null,
        (some) => some.fold(
          (e) => e,
          (_) => null,
        ),
      );
}
