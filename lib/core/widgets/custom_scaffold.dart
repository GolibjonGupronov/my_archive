import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_archive/core/app_router/app_router.dart';

typedef UnsavedChangesChecker = bool Function();
typedef WillPop = Future<bool> Function();

class CustomScaffold extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool canPop;
  final UnsavedChangesChecker? hasUnsavedChanges;
  final WillPop? onWillPop;
  final String? dialogTitle;
  final bool isBottomSafe;
  final bool isTopSafe;
  final String? dialogSubtitle;

  const CustomScaffold({
    super.key,
    this.appBar,
    this.backgroundColor,
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.floatingActionButton,
    this.canPop = true,
    this.hasUnsavedChanges,
    this.isBottomSafe = true,
    this.isTopSafe = false,
    this.onWillPop,
    this.dialogTitle,
    this.dialogSubtitle,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) async {
        if (didPop) return;

        if (!widget.canPop) return;

        if (widget.onWillPop != null) {
          final allowed = await widget.onWillPop?.call() ?? true;
          if (!allowed) {
            return;
          }
        }

        final hasChanges = widget.hasUnsavedChanges?.call() ?? false;

        if (!hasChanges) {
          if (router.canPop()) {
            router.pop();
          } else {
            final now = DateTime.now();
            if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
              _lastBackPressed = now;
              // showSuccessToast(context, tr('again_to_exit'));
            } else {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            }
          }
          return;
        }

        // await showConfirmDialog(
        //   context,
        //   widget.dialogTitle ?? tr('exit_confirm_title'),
        //   subTitle: widget.dialogSubtitle ?? tr('exit_confirm_subtitle'),
        //   onConfirm: () => router.pop(),
        //   type: MyDialogType.warning,
        // );
      },
      child: SafeArea(
        top: widget.isTopSafe,
        bottom: widget.isBottomSafe,
        child: Scaffold(
          appBar: widget.appBar,
          backgroundColor: widget.backgroundColor,
          body: widget.body,
          bottomNavigationBar: widget.bottomNavigationBar,
          drawer: widget.drawer,
          floatingActionButton: widget.floatingActionButton,
        ),
      ),
    );
  }
}
