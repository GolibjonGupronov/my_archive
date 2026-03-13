import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/widgets/dialogs/date_time_picker.dart';
import 'package:my_archive/features/auth/domain/use_cases/registration_use_case.dart';
import 'package:my_archive/features/auth/presentation/registration/blocs/registration/registration_bloc.dart';
import 'package:my_archive/features/auth/presentation/registration/blocs/registration/registration_event.dart';
import 'package:my_archive/features/auth/presentation/registration/blocs/registration/registration_state.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static const String tag = '/registration_page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();

  final phoneMaskFormatter = phoneNumberMask(mask: '(##) ###-##-##');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationBloc(sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    debugPrint("GGQ => RegistrationPage");
    final bloc = BlocProvider.of<RegistrationBloc>(context);

    return BlocListener<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => previous.regStatus != current.regStatus,
      listener: (context, state) {
        if (state.regStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.regStatus.isSuccess) {
          if (state.params != null) {
            router.push(RegSmsPage.tag, extra: state.params);
          }
        }
      },
      child: CustomScaffold(
        hasUnsavedChanges: () => true,
        dialogTitle: "Ortga qaytmoqchimisiz",
        dialogSubtitle: "",
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
                    TextView("Siz kiritgan raqamga tasdiqlash kodi yuboramiz", fontSize: 14),
                    24.height,
                    Row(
                      children: [
                        BoxContainer(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          borderRadius: BorderRadius.circular(30.r),
                          child: SizedBox(
                            height: 60.h,
                            child: Row(
                              children: [
                                Assets.icons.circleFlagUz.svg(width: 26.w, height: 26.w, fit: BoxFit.cover),
                                4.width,
                                TextView("+998 "),
                              ],
                            ),
                          ),
                        ),
                        8.width,
                        Expanded(
                          child: CustomTextField.phone(
                            "",
                            controller: phoneController,
                            hint: "(00) 000-00-00",
                            inputFormatters: [phoneMaskFormatter],
                            autofocus: true,
                            onChanged: (value) {
                              bloc.add(UpdateFieldEvent(phone: value));
                            },
                          ),
                        ),
                      ],
                    ),
                    8.height,
                    CustomTextField(
                      "Ism",
                      controller: firstNameController,
                      hint: "Masalan: G'olibjon",
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
                        return CustomRadioList(
                          "Jins",
                          segments: Gender.values,
                          getSegmentTitle: (value) => value.title,
                          onSegmentSelected: (selected) => bloc.add(UpdateFieldEvent(gender: selected)),
                          activeSegment: state,
                          activeGradient: state == Gender.male ? Gradients.primaryGradient : Gradients.pinkGradient,
                        );
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
                            DateTimePicker.cupertinoDate(context, result: (result) {
                              bloc.add(UpdateFieldEvent(birthDay: result));
                            });
                          },
                          rightWidget: Icon(CupertinoIcons.calendar),
                          value: state.formattedDate,
                        );
                      },
                    ),
                    30.height,
                  ],
                ),
              ),
              20.height,
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  return CustomButton(
                    "Sms yuborish",
                    () {
                      context.hideKeyboard;
                      bloc.add(
                        SubmitEvent(
                          params: RegistrationParams(
                            phone: "+998 ${phoneController.text}",
                            firstName: firstNameController.text,
                            secondName: secondNameController.text,
                            gender: state.gender,
                            birthDay: state.birthDay!,
                            smsCode: '',
                          ),
                        ),
                      );
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
