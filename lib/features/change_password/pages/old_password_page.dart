import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/change_password/blocs/old/old_password_bloc.dart';
import 'package:my_archive/features/change_password/blocs/old/old_password_event.dart';
import 'package:my_archive/features/change_password/blocs/old/old_password_state.dart';

class OldPasswordPage extends StatelessWidget {
  OldPasswordPage({super.key});

  static const String tag = '/old_password_page';

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OldPasswordBloc(oldPasswordUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<OldPasswordBloc>(context);

    return BlocListener<OldPasswordBloc, OldPasswordState>(
      listenWhen: (p, c) => p.passwordStatus != c.passwordStatus,
      listener: (context, state) {
        if (state.passwordStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.passwordStatus.isSuccess) {
          router.push(NewPasswordPage.tag);
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
                "Eski parol",
                controller: passwordController,
                onChanged: (value) {
                  bloc.add(UpdateFieldEvent(password: value));
                },
                canCopyPaste: false,
              ),
              30.height,
              BlocBuilder<OldPasswordBloc, OldPasswordState>(
                builder: (context, state) {
                  return CustomButton(tr('send'), () {
                    context.hideKeyboard;
                    bloc.add(SubmitEvent(password: passwordController.text));
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
