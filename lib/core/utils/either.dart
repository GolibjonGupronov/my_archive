abstract class Either<L, R> {
  const Either();

  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight);

  bool get isLeft => this is Left<L, R>;

  bool get isRight => this is Right<L, R>;

  L? get left => this is Left<L, R> ? (this as Left<L, R>).value : null;

  R? get right => this is Right<L, R> ? (this as Right<L, R>).value : null;
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) {
    return onLeft(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) {
    return onRight(value);
  }
}
