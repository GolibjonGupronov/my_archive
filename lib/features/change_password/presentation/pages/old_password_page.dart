import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/exports/route_exports.dart';
import 'package:my_archive/core/utils/logger.dart';
import 'package:my_archive/features/change_password/presentation/blocs/old/old_password_bloc.dart';
import 'package:my_archive/features/change_password/presentation/blocs/old/old_password_event.dart';
import 'package:my_archive/features/change_password/presentation/blocs/old/old_password_state.dart';

class OldPasswordPage extends StatefulWidget {
  const OldPasswordPage({super.key});

  static const String path = '/old_password_page';

  @override
  State<OldPasswordPage> createState() => _OldPasswordPageState();
}

class _OldPasswordPageState extends State<OldPasswordPage> {
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OldPasswordBloc(oldPasswordUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    logger("GGQ => OldPasswordPage");
    final bloc = BlocProvider.of<OldPasswordBloc>(context);

    return BlocListener<OldPasswordBloc, OldPasswordState>(
      listenWhen: (p, c) => p.passwordStatus != c.passwordStatus,
      listener: (context, state) {
        if (state.passwordStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.passwordStatus.isSuccess) {
          router.push(NewPasswordPage.path);
        }
      },
      child: CustomScaffold(
        appBar: CustomAppBar(""),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            primary: false,
            children: [
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
