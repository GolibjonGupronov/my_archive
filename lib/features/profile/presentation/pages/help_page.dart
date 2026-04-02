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
            ],
          )
        ],
      ),
    );
  }
}
