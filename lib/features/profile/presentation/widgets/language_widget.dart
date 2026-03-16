import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_archive/core/core_exports.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  late LangType _curLang;
  final PrefManager _prefManager = sl.get<PrefManager>();

  @override
  void initState() {
    _curLang = _prefManager.getLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
                  });
                },
                child: BoxContainer(
                  color: context.isDarkModeEnable ? AppColors.scaffoldDarkBackground : AppColors.foregroundSecondary,
                  borderRadius: BorderRadius.circular(40.r),
                  padding: EdgeInsets.all(16.w),
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
          CustomButton(
            tr('save'),
            () {
              changeLanguage(context, _curLang);
            },
          ),
          context.safeBottomSpace(16),
        ],
      ),
    );
  }

  Future<void> changeLanguage(BuildContext context, LangType lang) async {
    _prefManager.setLanguage(lang);
    await context.setLocale(lang.locale);
    await Get.updateLocale(lang.locale);
    router.pop();
  }
}
