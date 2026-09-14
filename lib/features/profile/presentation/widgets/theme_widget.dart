import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView("Mavzu tanlang"),
          16.height,
          Row(
            children: AdaptiveThemeMode.values.map(
                  (item) => Column(
                    children: [

                    ],
                  )
            ).toList(),
          ),
          CustomButton(tr('save'), () {}),
          16.height,
        ],
      ),
    );
  }
}
