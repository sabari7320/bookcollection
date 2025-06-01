import 'package:equatable/equatable.dart';
import 'package:mybooks/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class UsecaseWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
