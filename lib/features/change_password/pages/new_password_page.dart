import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/entities/password_check_entity.dart';
import 'package:my_archive/features/change_password/blocs/new/new_password_bloc.dart';
import 'package:my_archive/features/change_password/blocs/new/new_password_event.dart';
import 'package:my_archive/features/change_password/blocs/new/new_password_state.dart';
import 'package:my_archive/features/change_password/widgets/password_item_text.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key});

  static const String tag = '/new_password_page';

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController againNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewPasswordBloc(newPasswordUseCase: sl(), prefManager: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<NewPasswordBloc>(context);

    return BlocListener<NewPasswordBloc, NewPasswordState>(
      listenWhen: (p, c) => p.passwordStatus != c.passwordStatus,
      listener: (context, state) {
        if (state.passwordStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.passwordStatus.isSuccess) {
          router.go(SplashPage.tag);
        }
      },
      child: CustomScaffold(
        appBar: CustomAppBar(""),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            primary: false,
            children: [
              10.height,
              LogoWidget(),
              8.height,
              TextView("Parol almashtirish", fontSize: 24.sp),
              20.height,
              CustomTextField(
                "Yangi parol",
                controller: newPassword,
                onChanged: (value) {
                  bloc.add(UpdateFieldEvent(newPassword: value));
                },
                canCopyPaste: false,
              ),
              20.height,
              CustomTextField(
                "Yangi parolni tasdiqlash",
                controller: againNewPassword,
                onChanged: (value) {
                  bloc.add(UpdateFieldEvent(againNewPassword: value));
                },
                canCopyPaste: false,
              ),
              8.height,
              BlocSelector<NewPasswordBloc, NewPasswordState, PasswordCheckEntity>(
                selector: (state) => state.checkText,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PasswordItemText(isActive: state.upperText, text: "Kamida bitta katta harf"),
                      PasswordItemText(isActive: state.lowerText, text: "Kamida bitta kichik harf"),
                      PasswordItemText(isActive: state.number, text: "Kamida bitta raqam"),
                      PasswordItemText(isActive: state.char, text: "Kamida bitta belgi (!@#...)"),
                      PasswordItemText(isActive: state.length, text: "Kamida ${Constants.passwordLength} ta belgi"),
                    ],
                  );
                },
              ),
              30.height,
              BlocBuilder<NewPasswordBloc, NewPasswordState>(
                builder: (context, state) {
                  return CustomButton(tr('send'), () {
                    context.hideKeyboard;
                    bloc.add(SubmitEvent(password: newPassword.text));
                  }, active: state.isActive, progress: state.passwordStatus.isInProgress);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
