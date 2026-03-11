enum StateStatus { initial, inProgress, success, failure, canceled }

extension StateStateExtension on StateStatus {
  bool get isInitial => this == StateStatus.initial;

  bool get isInProgress => this == StateStatus.inProgress;

  bool get isSuccess => this == StateStatus.success;

  bool get isFailure => this == StateStatus.failure;

  bool get isCanceled => this == StateStatus.canceled;
}
