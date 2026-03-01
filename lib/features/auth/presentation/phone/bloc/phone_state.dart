import 'package:my_archive/core/core_exports.dart';

class PhoneState {
  final StateStatus phoneStatus;
  final String errorMessage;
  final AuthNextPage authNextPage;
  final bool isActive;
  final String phone;

  PhoneState({
    this.phoneStatus = StateStatus.initial,
    this.errorMessage = '',
    this.authNextPage = AuthNextPage.registration,
    this.isActive = false,
    this.phone = '',
  });

  PhoneState copyWith({
    StateStatus? phoneStatus,
    String? errorMessage,
    AuthNextPage? authNextPage,
    bool? isActive,
    String? phone,
  }) =>
      PhoneState(
        phoneStatus: phoneStatus ?? this.phoneStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        authNextPage: authNextPage ?? this.authNextPage,
        isActive: isActive ?? this.isActive,
        phone: phone ?? this.phone,
      );
}
