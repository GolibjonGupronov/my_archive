import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/di/injection_container.dart';
import 'package:my_archive/core/exports/route_exports.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/local_storage/pref_manager.dart';
import 'package:my_archive/core/utils/logger.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';
import 'package:my_archive/features/profile/presentation/widgets/language_widget.dart';
import 'package:my_archive/features/profile/presentation/widgets/profile_item.dart';
import 'package:my_archive/features/profile/presentation/widgets/theme_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String tag = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with WidgetsBindingObserver {
  late ProfileBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc(prefManager: sl(), changeImageUseCase: sl(), enableNotificationUseCase: sl(), userInfoUseCase: sl())
      ..add(InitEvent());
    WidgetsBinding.instance.addObserver(this);
    bloc.add(IsGrantedEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    bloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      bloc.add(IsGrantedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    logger("GGQ => SettingsPage");
    return BlocProvider.value(value: bloc, child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);

    return CustomScaffold(
      appBar: CustomAppBar(tr('settings')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Column(
            spacing: 20.h,
            children: [
              ProfileItem(
                title: "Mavzu",
                prefixIconData: CupertinoIcons.moon_fill,
                onTap: () {
                  showCustomBottomSheetDialog(context: context, child: ThemeWidget());
                },
                suffixWidget: Row(
                  children: [
                    TextView(AdaptiveTheme.of(context).mode.isLight ? tr('theme_light') : tr('theme_dark'),
                        maxLines: 1, color: AppColors.gray),
                    4.width,
                    Icon(CupertinoIcons.chevron_forward, color: AppColors.gray),
                  ],
                ),
              ),
              BlocSelector<ProfileBloc, ProfileState, ({bool isGranted, bool isNotificationEnabled})>(
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
                              bloc.add(EnableNotificationEvent(value: value));
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
              ProfileItem(
                title: "Xotira",
                prefixIconData: Icons.memory_rounded,
                onTap: () {
                  context.push(MemoryPage.tag);
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
