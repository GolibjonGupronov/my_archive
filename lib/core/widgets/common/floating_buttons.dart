import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/main.dart';

class FloatingButtons extends StatefulWidget {
  const FloatingButtons({super.key});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  Offset _offset = const Offset(32, 48);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _offset.dy,
      left: _offset.dx,
      child: Visibility(
        visible: isVisible,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() => _offset += details.delta);
          },
          child: Row(
            spacing: 14,
            children: [
              GestureDetector(
                onTap: () => alice.showInspector(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.http, color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: () => _changeLanguage(),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: Center(child: Text(sl.get<PrefManager>().getLanguage.key, style: TextStyle(color: AppColors.white))),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
                },
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        AdaptiveTheme.of(context).mode.isDark ? Icons.light_mode : Icons.dark_mode,
                        color: AppColors.white,
                        size: 20,
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

  void _changeLanguage() async {
    final pref = sl.get<PrefManager>();
    final currentLang = pref.getLanguage;
    final next = currentLang.next;
    pref.setLanguage(next);
    context.setLocale(next.locale);
    await Get.updateLocale(next.locale);
    // await initializeDateFormatting(next.key);
  }

  bool get isVisible => kDebugMode;
}
