import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';

class PhoneState {
  final StateStatus phoneStatus;
  final String errorMessage;
  final AuthNextPage authNextPage;

  PhoneState({
    this.phoneStatus = StateStatus.initial,
    this.errorMessage = '',
    this.authNextPage = AuthNextPage.registration,
  });

  PhoneState copyWith({
    StateStatus? phoneStatus,
    String? errorMessage,
    AuthNextPage? authNextPage,
  }) =>
      PhoneState(
        phoneStatus: phoneStatus ?? this.phoneStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        authNextPage: authNextPage ?? this.authNextPage,
      );
}
