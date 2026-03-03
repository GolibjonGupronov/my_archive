import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/sms/reset_sms_bloc.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/sms/reset_sms_event.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/sms/reset_sms_state.dart';

class ResetSmsPage extends StatelessWidget {
  final String phoneNumber;

  const ResetSmsPage({super.key, required this.phoneNumber});

  static const String tag = '/reset_sms_page';
  static final TextEditingController smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ResetSmsBloc(checkSmsUseCase: sl(), userInfoUseCase: sl(), sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ResetSmsBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ResetSmsBloc, ResetSmsState>(
          listenWhen: (previous, current) => previous.smsStatus != current.smsStatus,
          listener: (context, state) {
            if (state.smsStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            } else if (state.smsStatus.isSuccess) {
              router.push(SplashPage.tag);
            }
          },
        ),
        BlocListener<ResetSmsBloc, ResetSmsState>(
          listenWhen: (previous, current) => previous.resendPhoneStatus != current.resendPhoneStatus,
          listener: (context, state) {
            if (state.resendPhoneStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        hasUnsavedChanges: () => true,
        dialogTitle: "Ortga qaytmoqchimisiz",
        dialogSubtitle: "",
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            primary: false,
            children: [
              60.height,
              LogoWidget(),
              8.height,
              TextView(tr('verify_phone'), fontWeight: FontWeight.bold, fontSize: 24),
              12.height,
              TextView(tr('otp_sent', args: [phoneNumber]), fontSize: 14),
              24.height,
              CustomPinPut(
                context: context,
                controller: smsCodeController,
                length: Constants.smsCodeLength,
                onChanged: (value) {
                  bloc.add(UpdateFieldEvent(code: smsCodeController.text));
                },
              ),
              12.height,
              BlocSelector<ResetSmsBloc, ResetSmsState, ({StateStatus resendPhoneStatus, int second})>(
                  selector: (state) => (resendPhoneStatus: state.resendPhoneStatus, second: state.second),
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (state.second == 0 && !(state.resendPhoneStatus.isInProgress)) {
                            bloc.add(ResendPhoneEvent(phone: phoneNumber.phoneReplace));
                          }
                        },
                        child: (state.resendPhoneStatus.isInProgress)
                            ? Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: CupertinoActivityIndicator())
                            : state.second == 0
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(CupertinoIcons.refresh, size: 20),
                                      4.width,
                                      TextView(tr('resend'), fontSize: 14)
                                    ],
                                  )
                                : TextView(state.second.toMmSs, textAlign: TextAlign.center, enableTabularFigures: true),
                      ),
                    );
                  }),
              20.height,
              BlocBuilder<ResetSmsBloc, ResetSmsState>(
                buildWhen: (p, c) => p.resendPhoneStatus == c.resendPhoneStatus && p.second == c.second,
                builder: (context, state) {
                  return CustomButton(
                    "Tasdiqlash",
                    () {
                      context.hideKeyboard;
                      final phone = "+998${phoneNumber.phoneReplace}";
                      bloc.add(SubmitEvent(params: CheckSmsParams(phone: phone, sms: smsCodeController.text)));
                    },
                    active: state.isActive,
                    progress: state.smsStatus.isInProgress,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
