import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/enums/gender.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/date_time.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/extensions/string.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/common/logo_widget.dart';
import 'package:my_archive/core/widgets/dialogs/custom_dialog.dart';
import 'package:my_archive/core/widgets/dialogs/regular_dialog.dart';
import 'package:my_archive/core/widgets/pinput.dart';
import 'package:my_archive/core/widgets/radio_list.dart';
import 'package:my_archive/core/widgets/scaffold.dart';
import 'package:my_archive/core/widgets/select_field.dart';
import 'package:my_archive/core/widgets/text_field.dart';
import 'package:my_archive/core/widgets/text_view.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_bloc.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_event.dart';
import 'package:my_archive/features/auth/presentation/registration/bloc/registration_state.dart';

class RegistrationPage extends StatelessWidget {
  final String phoneNumber;

  const RegistrationPage({super.key, required this.phoneNumber});

  static const String tag = '/registration_page';
  static final TextEditingController codeController = TextEditingController();
  static final TextEditingController firstNameController = TextEditingController();
  static final TextEditingController secondNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationBloc(sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<RegistrationBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) => previous.regStatus != current.regStatus,
          listener: (context, state) {
            if (state.regStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            } else if (state.regStatus.isSuccess) {
              router.go(MainPage.tag);
            }
          },
        ),
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) => previous.resendPhoneStatus != current.resendPhoneStatus,
          listener: (context, state) {
            if (state.resendPhoneStatus.isFailure) {
              showErrorDialog(context, title: state.errorMessage);
            }
          },
        ),
      ],
      child: CustomScaffold(
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  primary: false,
                  children: [
                    60.height,
                    LogoWidget(),
                    8.height,
                    TextView(tr('sign_up'), fontWeight: FontWeight.bold, fontSize: 24),
                    12.height,
                    TextView(tr('register_with_phone', args: [phoneNumber]), fontSize: 14),
                    24.height,
                    CustomTextField(
                      "Ism",
                      controller: firstNameController,
                      hint: "Masalan: G'olibjon",
                      // autofocus: true,
                      onChanged: (value) {
                        bloc.add(UpdateFieldEvent(firstName: value));
                      },
                    ),
                    8.height,
                    CustomTextField(
                      "Familiya",
                      controller: secondNameController,
                      hint: "Masalan: G'upronov",
                      onChanged: (value) {
                        bloc.add(UpdateFieldEvent(secondName: value));
                      },
                    ),
                    8.height,
                    BlocSelector<RegistrationBloc, RegistrationState, Gender>(
                      selector: (state) => state.gender,
                      builder: (context, state) {
                        debugPrint("GGQ => Gender");
                        return CustomRadioList("Jins",
                            segments: Gender.values,
                            getSegmentTitle: (value) => value.title,
                            onSegmentSelected: (selected) => bloc.add(UpdateFieldEvent(gender: selected)),
                            activeSegment: state);
                      },
                    ),
                    8.height,
                    BlocSelector<RegistrationBloc, RegistrationState, DateTime?>(
                      selector: (state) => state.birthDay,
                      builder: (context, state) {
                        debugPrint("GGQ => Birthday");
                        return CustomSelectField(
                          "Tug'ilgan kun",
                          "kk.oo.yyyy",
                          () {
                            showCustomSingleDatePicker(context, result: (result) {
                              bloc.add(UpdateFieldEvent(birthDay: result));
                            });
                          },
                          rightWidget: Icon(CupertinoIcons.calendar),
                          value: state.formattedDate,
                        );
                      },
                    ),
                    24.height,
                    CustomPinPut(
                      context: context,
                      controller: codeController,
                      length: Constants.smsCodeLength,
                      onChanged: (value) {
                        bloc.add(UpdateFieldEvent(code: codeController.text));
                      },
                    ),
                    12.height,
                    BlocSelector<RegistrationBloc, RegistrationState, ({StateStatus resendPhoneStatus, int second})>(
                        selector: (state) => (resendPhoneStatus: state.resendPhoneStatus, second: state.second),
                        builder: (context, state) {
                          // debugPrint("GGQ => Refresh");
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
                    30.height,
                  ],
                ),
              ),
              20.height,
              BlocBuilder<RegistrationBloc, RegistrationState>(
                buildWhen: (p, c) => p.resendPhoneStatus == c.resendPhoneStatus && p.second == c.second,
                builder: (context, state) {
                  return CustomButton(
                    "Tasdiqlash",
                        () {
                      context.hideKeyboard;
                      // final phone = "+998${phoneNumber.phoneReplace}";
                      // bloc.add(SubmitEvent(params: CheckSmsParams(phone: phone, sms: codeController.text)));
                    },
                    active: state.isActive,
                    progress: state.regStatus.isInProgress,
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
