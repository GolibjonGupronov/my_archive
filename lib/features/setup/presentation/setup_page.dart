import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/setup/presentation/widgets/lang_widget.dart';
import 'package:my_archive/features/setup/presentation/widgets/theme_widget.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  static const String tag = '/setup_page';

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final List<Widget> pages = [LangWidget(), ThemeWidget(), LangWidget()];
  late final PageController _controller;
  int _currentIndex = 0;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentIndex);
    _isLastPage = _currentIndex == pages.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(tr('settings')),
      body: Column(
        children: [
          20.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: pages
                  .mapIndexed(
                    (index, item) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == pages.length - 1 ? 0 : 12.w),
                        child: LinearProgressIndicator(
                          value: _currentIndex >= index ? 1 : 0,
                          color: AppColors.primary,
                          backgroundColor: AppColors.gray,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: pages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _isLastPage = _currentIndex == pages.length - 1;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w,bottom: 16.h),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                  "Orqaga",
                  () {
                    if (_currentIndex > 0) {
                      _controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                  active: _currentIndex != 0,
                )),
                8.width,
                Expanded(
                    child: CustomButton(_isLastPage ? "Yakunlash" : "Oldinga", () {
                  if (_isLastPage) {
                    context.go(SplashPage.tag);
                  } else {
                    _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }
                })),
              ],
            ),
          )
        ],
      ),
    );
  }
}
