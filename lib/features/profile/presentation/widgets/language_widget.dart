import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  late LangType currentLanguage;
  final PrefManager prefManager = sl.get<PrefManager>();

  @override
  void initState() {
    currentLanguage = prefManager.getLanguage;
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
              child: InkWell(
                onTap: () {
                  if (currentLanguage == item) return;
                  setState(() {
                    currentLanguage = item;
                  });
                },
                child: BoxContainer(
                  color: context.isDarkModeEnable?AppColors.scaffoldDarkBackground:AppColors.foregroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        currentLanguage == item ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                        color: currentLanguage == item ? AppColors.primary : AppColors.gray,
                      ),
                      12.width,
                      item.iconSvg.svg(width: 26.w),
                      8.width,
                      Expanded(
                        child: TextView(
                          item.title,
                          fontWeight: currentLanguage == item ? FontWeight.w600 : FontWeight.w400,
                          color: currentLanguage == item ? AppColors.primary : AppColors.gray,
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
              changeLanguage(context, currentLanguage);
            },
          ),
          context.safeBottomSpace(16),
        ],
      ),
    );
  }

  void changeLanguage(BuildContext context, LangType lang) async {
    prefManager.setLanguage(lang);
    context.setLocale(lang.locale);
    await Get.updateLocale(lang.locale);
    initializeDateFormatting(lang.key);
    router.go(SplashPage.tag);
  }
}
