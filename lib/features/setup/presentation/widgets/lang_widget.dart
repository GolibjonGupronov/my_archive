import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_archive/core/core_exports.dart';

class LangWidget extends StatefulWidget {
  const LangWidget({super.key});

  @override
  State<LangWidget> createState() => _LangWidgetState();
}

class _LangWidgetState extends State<LangWidget> {
  late LangType _curLang;
  final PrefManager _prefManager = sl.get<PrefManager>();

  @override
  void initState() {
    super.initState();
    _curLang = _prefManager.getLanguage;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.setLocale(_curLang.locale);
      Get.updateLocale(_curLang.locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: BoxContainer(
          color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.white,
          padding: EdgeInsets.all(20.w),
          borderRadius: BorderRadius.circular(20.r),
          shadows: [
            BoxShadow(color: AppColors.shadow.withValues(alpha: 0.2), spreadRadius: 1, blurRadius: 20, offset: const Offset(1, 1))
          ],
          child: Column(
            children: [
              TextView(tr('select_language')),
              16.height,
              ...LangType.values.map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Bounce(
                    onTap: () {
                      if (_curLang == item) return;
                      setState(() {
                        _curLang = item;
                        context.setLocale(item.locale);
                        Get.updateLocale(item.locale);
                      });
                    },
                    child: BoxContainer(
                      color: context.isDarkModeEnable ? AppColors.scaffoldDarkBackground : AppColors.foregroundSecondary,
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            _curLang == item ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                            color: _curLang == item ? AppColors.primary : AppColors.gray,
                          ),
                          12.width,
                          item.iconSvg.svg(width: 26.w),
                          8.width,
                          Expanded(
                            child: TextView(
                              item.title,
                              fontWeight: _curLang == item ? FontWeight.w600 : FontWeight.w400,
                              color: _curLang == item ? AppColors.primary : AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
