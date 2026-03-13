import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/widgets/dialogs/date_time_picker.dart';
import 'package:my_archive/features/auth/domain/entities/user_info_entity.dart';
import 'package:my_archive/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:my_archive/features/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:my_archive/features/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:my_archive/features/profile/domain/use_cases/edit_profile_use_case.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const String tag = '/edit_profile_page';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserInfoEntity? user = sl
      .get<PrefManager>()
      .getUserInfo;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    if (user != null) {
      firstNameController.text = user!.firstName;
      secondNameController.text = user!.secondName;

      phoneController.text = user!.phone.phoneFormatter(mask: '(##) ###-##-##');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      EditProfileBloc(editProfileUseCase: sl(), userInfoUseCase: sl())
        ..add(InitEvent(
          firstName: user?.firstName,
          secondName: user?.secondName,
          birthDay: user?.birthday.toDateTime,
          gender: user?.gender,
        )),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<EditProfileBloc>(context);

    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.editStatus != current.editStatus,
      listener: (context, state) {
        if (state.editStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        } else if (state.editStatus.isSuccess) {
          router.pop(true);
        }
      },
      child: BlocSelector<EditProfileBloc, EditProfileState, bool>(
        selector: (state) => state.isChanged,
        builder: (context, state) {
          debugPrint("GGQ => state.isChanged");
          return CustomScaffold(
            hasUnsavedChanges: () => state,
            appBar: CustomAppBar(""),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      primary: false,
                      children: [
                        LogoWidget(),
                        8.height,
                        TextView("Ma'lumotlarim", fontWeight: FontWeight.bold, fontSize: 24),
                        24.height,
                        Row(
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: BoxContainer(
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
                            ),
                            8.width,
                            Expanded(
                              child: CustomTextField.phone(
                                "",
                                controller: phoneController,
                                hint: "(00) 000-00-00",
                                enabled: false,
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
                        BlocSelector<EditProfileBloc, EditProfileState, Gender>(
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
                        BlocSelector<EditProfileBloc, EditProfileState, DateTime?>(
                          selector: (state) => state.birthDay,
                          builder: (context, state) {
                            debugPrint("GGQ => Birthday");
                            return CustomSelectField(
                              "Tug'ilgan kun",
                              "kk.oo.yyyy",
                                  () {
                                DateTimePicker.cupertinoDate(context, result: (result) {
                                  bloc.add(UpdateFieldEvent(birthDay: result));
                                }, initialDate: state);
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
                  BlocBuilder<EditProfileBloc, EditProfileState>(
                    builder: (context, state) {
                      return CustomButton(
                        tr('save'),
                            () {
                          context.hideKeyboard;
                          bloc.add(
                            SubmitEvent(
                              params: EditProfileParams(
                                firstName: firstNameController.text,
                                secondName: secondNameController.text,
                                gender: state.gender,
                                birthDay: state.birthDay!,
                              ),
                            ),
                          );
                        },
                        active: state.isActive,
                        progress: state.editStatus.isInProgress,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
