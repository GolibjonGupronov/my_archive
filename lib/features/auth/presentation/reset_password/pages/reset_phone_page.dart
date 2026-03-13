import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/phone/reset_phone_bloc.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/phone/reset_phone_event.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/phone/reset_phone_state.dart';

class ResetPhonePage extends StatefulWidget {
  const ResetPhonePage({super.key});

  static const String tag = '/reset_phone_page';

  @override
  State<ResetPhonePage> createState() => _ResetPhonePageState();
}

class _ResetPhonePageState extends State<ResetPhonePage> {
  final TextEditingController phoneController = TextEditingController();
  final phoneMaskFormatter = phoneNumberMask(mask: '(##) ###-##-##');

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ResetPhoneBloc(sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    debugPrint("GGQ => ResetPhonePage");
    final bloc = BlocProvider.of<ResetPhoneBloc>(context);

    return BlocListener<ResetPhoneBloc, ResetPhoneState>(
      listenWhen: (p, c) => p.phoneStatus != c.phoneStatus,
      listener: (context, state) {
        if (state.phoneStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.phoneStatus.isSuccess) {
          router.push(ResetSmsPage.tag, extra: "+998 ${state.phone}");
        }
      },
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
              TextView("Parol tiklash", fontSize: 24.sp),
              8.height,
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
              20.height,
              BlocBuilder<ResetPhoneBloc, ResetPhoneState>(
                builder: (context, state) {
                  return CustomButton(tr('send'), () {
                    context.hideKeyboard;
                    bloc.add(SubmitEvent(phone: "+998${phoneController.text.phoneReplace}"));
                  }, active: state.isActive, progress: state.phoneStatus.isInProgress);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
