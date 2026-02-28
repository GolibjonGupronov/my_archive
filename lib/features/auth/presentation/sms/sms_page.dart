import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/extensions/string.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/common/logo_widget.dart';
import 'package:my_archive/core/widgets/dialogs/custom_dialog.dart';
import 'package:my_archive/core/widgets/pinput.dart';
import 'package:my_archive/core/widgets/scaffold.dart';
import 'package:my_archive/core/widgets/text_view.dart';
import 'package:my_archive/features/auth/domain/use_cases/check_sms_use_case.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_bloc.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_event.dart';
import 'package:my_archive/features/auth/presentation/sms/bloc/sms_state.dart';

class SmsPage extends StatelessWidget {
  final String phoneNumber;

  const SmsPage({super.key, required this.phoneNumber});

  static const String tag = '/sms_page';
  static final TextEditingController smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SmsBloc(checkSmsUseCase: sl(), userInfoUseCase: sl(), sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SmsBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<SmsBloc, SmsState>(
          listenWhen: (previous, current) => previous.smsStatus != current.smsStatus,
          listener: (context, state) {
            if (state.smsStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            } else if (state.smsStatus.isSuccess) {
              router.go(MainPage.tag);
            }
          },
        ),
        BlocListener<SmsBloc, SmsState>(
          listenWhen: (previous, current) => previous.resendPhoneStatus != current.resendPhoneStatus,
          listener: (context, state) {
            if (state.resendPhoneStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        hasUnsavedChanges: ()=> true,
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
              BlocSelector<SmsBloc, SmsState, ({StateStatus resendPhoneStatus, int second})>(
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
              BlocBuilder<SmsBloc, SmsState>(
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
