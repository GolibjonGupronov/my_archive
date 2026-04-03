import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const String tag = '/help_page';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar("Yordam"),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Column(
            spacing: 20.h,
            children: [
              ProfileItem(
                title: "FAQ",
                prefixIconData: CupertinoIcons.doc_text,
                onTap: () {
                  context.push(FaqPage.tag);
                },
              ),
              ProfileItem(
                title: "Qo'ng'iroq qilish",
                prefixIconData: CupertinoIcons.phone,
                onTap: () {
                  String number = sl.get<PrefManager>().getUserInfo?.callCenter ?? "";
                  if (number.isNotEmpty) {
                    _callCenter(context, number);
                  } else {
                    showErrorToast(context, "Telefon raqam topilmadi");
                  }
                },
              ),
              ProfileItem(
                title: "Telegram",
                prefixIconData: CupertinoIcons.chat_bubble_text,
                onTap: () {
                  String telegram = sl.get<PrefManager>().getUserInfo?.telegramBot ?? "";
                  if (telegram.isNotEmpty) {
                    openUrl(telegram);
                  } else {
                    showErrorToast(context, "Telegram topilmadi");
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> _callCenter(BuildContext context, String phone) async {
  return await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () {
                    context.pop();
                    callNumber(phone);
                  },
                  child: TextView(phone.phoneFormatter(), fontSize: 22.sp, fontWeight: FontWeight.bold)),
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  context.pop();
                },
                child: TextView(tr('cancel'), color: AppColors.red)),
          ));
}
