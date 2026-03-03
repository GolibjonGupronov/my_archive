import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/password/reset_password_bloc.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/password/reset_password_event.dart';
import 'package:my_archive/features/auth/presentation/reset_password/blocs/password/reset_password_state.dart';
import 'package:my_archive/features/auth/presentation/reset_password/widgets/password_item_text.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  static const String tag = '/reset_password_page';
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController againNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ResetPasswordBloc>(context);

    return CustomScaffold(
      hasUnsavedChanges: () => true,
      dialogTitle: "Ortga qaytmoqchimisiz",
      dialogSubtitle: "",
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          builder: (context, state) {
            return ListView(
              primary: false,
              children: [
                60.height,
                LogoWidget(),
                8.height,
                TextView("Parol tiklash", fontSize: 24.sp),
                20.height,
                CustomTextField(
                  "Yangi parol",
                  controller: newPassword,
                  onChanged: (value) {
                    bloc.add(UpdateFieldEvent(newPassword: value));
                  },
                  canCopyPaste: false,
                ),
                8.height,
                PasswordItemText(isActive: state.checkText.upperText, text: "Kamida bitta katta harf"),
                PasswordItemText(isActive: state.checkText.lowerText, text: "Kamida bitta kichik harf"),
                PasswordItemText(isActive: state.checkText.number, text: "Kamida bitta raqam"),
                PasswordItemText(isActive: state.checkText.char, text: "Kamida bitta belgi (!@#...)"),
                PasswordItemText(isActive: state.checkText.length, text: "Kamida ${Constants.passwordLength} ta belgi"),
                30.height,
                CustomTextField(
                  "Yangi parolni tasdiqlash",
                  controller: againNewPassword,
                  onChanged: (value) {
                    bloc.add(UpdateFieldEvent(againNewPassword: value));
                  },
                  canCopyPaste: false,
                ),
                30.height,
                CustomButton(tr('send'), () {
                  context.hideKeyboard;
                  // bloc.add(SubmitEvent(phone: "+998${phoneController.text.phoneReplace}"));
                }, active: state.isActive, progress: state.passwordStatus.isInProgress)
              ],
            );
          },
        ),
      ),
    );
  }
}
