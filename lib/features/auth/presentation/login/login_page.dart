import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/auth/domain/use_cases/login_use_case.dart';
import 'package:my_archive/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:my_archive/features/auth/presentation/login/bloc/login_event.dart';
import 'package:my_archive/features/auth/presentation/login/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String tag = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final phoneMaskFormatter = phoneNumberMask(mask: '(##) ###-##-##');

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(loginUseCase: sl(), userInfoUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (p, c) => p.loginStatus != c.loginStatus,
      listener: (context, state) {
        if (state.loginStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.loginStatus.isSuccess) {
          router.go(MainPage.tag);
        }
      },
      child: CustomScaffold(
        isExitDialog: true,
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
                    12.height,
                    CustomTextField.password(
                      "",
                      controller: passwordController,
                      hint: "Parol",
                      onChanged: (value) {
                        bloc.add(UpdateFieldEvent(password: value));
                      },
                    ),
                    20.height,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Bounce(
                        onTap: () {
                          router.push(ResetPhonePage.tag);
                        },
                        child:
                            TextView("Parolni unutdingizmi?", textDecoration: TextDecoration.underline, color: AppColors.primary),
                      ),
                    ),
                    20.height,
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return CustomButton(tr('send'), () {
                          context.hideKeyboard;
                          bloc.add(SubmitEvent(
                              params: LoginParams(
                                  phone: "+998${phoneController.text.phoneReplace}", password: passwordController.text)));
                        }, active: state.isActive, progress: state.loginStatus.isInProgress);
                      },
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  TextView("Akkauntingiz yo‘qmi?"),
                  8.width,
                  Bounce(
                      onTap: () {
                        context.push(RegistrationPage.tag);
                      },
                      child: TextView("Ro'yxatdan o'tish", textDecoration: TextDecoration.underline, color: AppColors.primary)),
                ],
              ),
              context.safeBottomSpace(8)
            ],
          ),
        ),
      ),
    );
  }
}
