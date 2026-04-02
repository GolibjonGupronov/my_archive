import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';
import 'package:my_archive/features/profile/presentation/widgets/language_widget.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  final ProfileBloc bloc;

  const SettingsPage({super.key, required this.bloc});

  static const String tag = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.bloc.add(IsGrantedEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.bloc.add(IsGrantedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(tr('settings')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Column(
            spacing: 20.h,
            children: [
              ProfileItem(
                title: "Tungi rejim",
                prefixIconData: CupertinoIcons.moon_fill,
                suffixWidget: CupertinoSwitch(
                  value: AdaptiveTheme.of(context).mode.isDark,
                  onChanged: (value) {
                    AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                  },
                ),
              ),
              BlocSelector<ProfileBloc, ProfileState, ({bool isGranted, bool isNotificationEnabled})>(
                bloc: widget.bloc,
                selector: (state) => (isGranted: state.isGranted, isNotificationEnabled: state.isNotificationEnabled),
                builder: (context, state) {
                  return ProfileItem(
                    title: "Bildirishnoma",
                    prefixIconData: CupertinoIcons.bell_fill,
                    onTap: !state.isGranted ? () => openAppSettings() : null,
                    suffixWidget: state.isGranted
                        ? CupertinoSwitch(
                            value: state.isNotificationEnabled,
                            onChanged: (value) {
                              widget.bloc.add(EnableNotificationEvent(value: value));
                            })
                        : Icon(CupertinoIcons.info_circle_fill, color: AppColors.red),
                  );
                },
              ),
              ProfileItem(
                title: "Til",
                prefixIconData: CupertinoIcons.globe,
                onTap: () {
                  showCustomBottomSheetDialog(context: context, child: LanguageWidget());
                },
                suffixWidget: Row(
                  children: [
                    TextView(sl.get<PrefManager>().getLanguage.title, maxLines: 1, color: AppColors.gray),
                    4.width,
                    Icon(CupertinoIcons.chevron_forward, color: AppColors.gray),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
