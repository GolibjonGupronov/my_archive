import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/extensions/string.dart';
import 'package:my_archive/core/utils/generated/assets.gen.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/scaffold.dart';
import 'package:my_archive/core/widgets/single_select_list.dart';
import 'package:my_archive/core/widgets/text_field.dart';
import 'package:my_archive/core/widgets/text_view.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_bloc.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_event.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_state.dart';
import 'package:overlay_support/overlay_support.dart';

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
    final List<SingleSelectItemModel> items =
        List<SingleSelectItemModel>.generate(80, (i) => SingleSelectItemModel("G'olibjon $i", i)); //

    return BlocListener<PhoneBloc, PhoneState>(
      listener: (context, state) {
        if (state.phoneStatus.isFailure) {
          toast(state.errorMessage);
        } else if (state.phoneStatus.isSuccess) {
          router.push(state.authNextPage.page);
          toast("success ${state.authNextPage}");
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
              Assets.images.logo.image(height: 200),
              8.height,
              TextView("Kirish", fontSize: 24.sp),
              8.height,
              Row(
                children: [
                  BoxContainer(
                    color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.foregroundSecondary,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    borderRadius: BorderRadius.circular(30.r),
                    child: SizedBox(
                      height: 60.h,
                      child: Row(
                        children: [
                          Assets.icons.circleFlagUz.svg(width: 26.w, height: 26.w, fit: BoxFit.cover),
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
                  return CustomButton(tr('enter'), () {
                    bloc.add(SendPhoneEvent(phone: "+998${phoneController.text.phoneReplace}"));
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
