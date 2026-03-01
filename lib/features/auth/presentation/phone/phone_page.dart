import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_bloc.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_event.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_state.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  static const String tag = '/phone_page';

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  late final TextEditingController phoneController;
  final phoneMaskFormatter =
      MaskTextInputFormatter(mask: '(##) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PhoneBloc(sendPhoneUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<PhoneBloc>(context);

    return BlocListener<PhoneBloc, PhoneState>(
      listenWhen: (p, c) => p.phoneStatus != c.phoneStatus,
      listener: (context, state) {
        if (state.phoneStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.phoneStatus.isSuccess) {
          router.push(state.authNextPage.page, extra: "+998 ${state.phone}");
        }
      },
      child: CustomScaffold(
        isExitDialog: true,
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            primary: false,
            children: [
              60.height,
              LogoWidget(),
              8.height,
              TextView(tr('enter'), fontSize: 24.sp),
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
              BlocBuilder<PhoneBloc, PhoneState>(
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
