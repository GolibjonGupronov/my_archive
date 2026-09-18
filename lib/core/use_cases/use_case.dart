import 'package:equatable/equatable.dart';
import 'package:my_archive/core/api/error/failure.dart';
import 'package:my_archive/core/utils/either.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> callUseCase(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
