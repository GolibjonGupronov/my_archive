import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/main/presentation/bloc/main_bloc.dart';
import 'package:my_archive/features/main/presentation/bloc/main_event.dart';
import 'package:my_archive/features/main/presentation/bloc/main_state.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  static const String tag = '/main_page';

  final List<BottomNavItemEntity> bottomNavigationItems = [
    BottomNavItemEntity('home', HomePage(), CupertinoIcons.house, BottomNavMainPage.home),
    BottomNavItemEntity('profile', ProfilePage(), CupertinoIcons.person_crop_circle, BottomNavMainPage.profile),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    debugPrint("GGQ => MainPage");
    final bloc = BlocProvider.of<MainBloc>(context);
    final pages = bottomNavigationItems.map((item) => item.page).toList();

    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return CustomScaffold(
          isExitDialog: true,
          resizeToAvoidBottomInset: false,
          body: Stack(alignment: Alignment.center, children: [
            IndexedStack(index: state.activePage.index, children: pages),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: BoxContainer(
                  color: (context.isDarkModeEnable ? AppColors.whiteDark : AppColors.foregroundSecondary).withValues(alpha: 0.96),
                  padding: EdgeInsets.all(4.w),
                  borderRadius: BorderRadius.circular(60.r),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: bottomNavigationItems.mapIndexed((index, item) {
                      return BottomNavItem(
                        onTap: () {
                          if (item.navItem != state.activePage) {
                            bloc.add(ActiveMainPageEvent(activePage: item.navItem));
                          }
                        },
                        isActive: state.activePage == item.navItem,
                        iconData: item.icon,
                        title: item.key.tr(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}
