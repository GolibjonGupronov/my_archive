import 'package:my_archive/core/core_exports.dart';

class CurrentPinState {
  final StateStatus checkCurrentPinStatus;
  final bool isActive;
  final String errorMessage;

  CurrentPinState({
    this.checkCurrentPinStatus = StateStatus.initial,
    this.isActive = false,
    this.errorMessage = '',
  });

  CurrentPinState copyWith({
    StateStatus? checkCurrentPinStatus,
    bool? isActive,
    String? errorMessage,
  }) =>
      CurrentPinState(
        checkCurrentPinStatus: checkCurrentPinStatus ?? this.checkCurrentPinStatus,
        isActive: isActive ?? this.isActive,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}