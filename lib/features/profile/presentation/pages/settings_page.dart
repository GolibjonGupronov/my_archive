import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/widgets/language_widget.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String tag = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("GGQ => SettingsPage");
    return CustomScaffold(
      appBar: CustomAppBar(tr('settings')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          ProfileItem(
              title: "Tungi rejim",
              rightWidget: CupertinoSwitch(
                  value: AdaptiveTheme.of(context).mode.isDark,
                  onChanged: (value) {
                    AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                  })),
          20.height,
          ProfileItem(
            title: "Bildirishnoma",
            onTap: () async {
              bool isGranted = await PermissionService.requestNotificationPermission();
              if (!isGranted) {
               await openAppSettings();
               setState((){});
              }
            },
            rightWidget: FutureBuilder<bool>(
              future: PermissionService.requestNotificationPermission(),
              builder: (context, snapshot) {
                bool isGranted = snapshot.data ?? false;
                return isGranted
                    ? CupertinoSwitch(value: isGranted, onChanged: (value) async {})
                    : Icon(CupertinoIcons.info_circle_fill, color: AppColors.red);
              },
            ),
          ),
          20.height,
          ProfileItem(
            title: "Til",
            onTap: () {
              showCustomBottomSheetDialog(context: context, child: LanguageWidget());
            },
            rightWidget: Row(
              children: [
                TextView(sl.get<PrefManager>().getLanguage.title, maxLines: 1),
                10.width,
                Icon(CupertinoIcons.chevron_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
