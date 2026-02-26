import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_archive/core/app_router/app_router.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/enums/gender.dart';
import 'package:my_archive/core/extensions/common.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/widgets/about_us_social.dart';
import 'package:my_archive/core/widgets/app_bar.dart';
import 'package:my_archive/core/widgets/box_conatiner.dart';
import 'package:my_archive/core/widgets/button.dart';
import 'package:my_archive/core/widgets/coming_soon.dart';
import 'package:my_archive/core/widgets/dialogs/regular_dialog.dart';
import 'package:my_archive/core/widgets/pinput.dart';
import 'package:my_archive/core/widgets/radio_list.dart';
import 'package:my_archive/core/widgets/scaffold.dart';
import 'package:my_archive/core/widgets/select_field.dart';
import 'package:my_archive/core/widgets/single_select_list.dart';
import 'package:my_archive/core/widgets/text_field.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_bloc.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_event.dart';
import 'package:my_archive/features/auth/presentation/phone/bloc/phone_state.dart';
import 'package:overlay_support/overlay_support.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  static const String tag = '/phone_page';

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
        appBar: CustomAppBar(
          "My Archive",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              BoxContainer(padding: EdgeInsets.all(8), borderRadius: BorderRadius.circular(16), withShadow: true, child: 100.box),
              16.height,
              CustomButton("ok", () {
                // showCustomDialog(context, child:Text("data"));
                // showConfirmDialog(context, "NImadur", subTitle: "erfghjk",type: MyDialogType.warning);
                // showSuccessDialog(context,title:  "NImadur", subTitle: "erfghjk");
                // showErrorToast(context, "message");
                // showCustomSingleDatePicker(context, result: (value) {});
                // showCustomRangeDatePicker(context, result: (value, jj) {});
                showCustomTimePicker(context, result: (s) {});
              }, active: true, progress: false, icon: CupertinoIcons.add_circled_solid),
              16.height,
              CustomSelectField(
                "title",
                "hint",
                () {
                  showDraggableBottomSheet(
                      context: context,
                      childBuilder: (controller) => SingleSelectListWidget(
                          items: items, selectedItem: 1, onSelect: (item) {}, scrollController: controller),
                      title: "");
                },
                comment: "iyhgj",
                progress: false,
                value: "",
              ),
              16.height,
              CustomTextField(
                "title",
                comment: "sdccs",
              ),
              16.height,
              CustomTextField.phone("title"),
              16.height,
              CustomTextField.password("title"),
              16.height,
              ComingSoonWidget(
                  isSoon: true,
                  child: CustomTextField.comment(
                    "title",
                    maxLines: 4,
                  )),
              16.height,
              CustomPinPut(
                context: context,
                validator: (ss) {
                  return "error";
                },
              ),
              16.height,
              CustomRadioList(
                "Gender",
                segments: Gender.values,
                getSegmentTitle: (s) => s.title,
                onSegmentSelected: (s) {},
                activeSegment: Gender.male,
              ),
              16.height,
              AboutUsSocial(),
              90.height,
            ],
          ),
        ),
      ),
    );
  }
}
