import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_archive/core/core_exports.dart';

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
  final bool isExitDialog;

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
    this.isExitDialog = false,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> with ExitAppMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) async {
        if (didPop) return;

        if (!widget.canPop) return;

        if (widget.isExitDialog) {
          final onExit = onExitApp(context);
          if (onExit) {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          }
          return;
        }

        if (widget.onWillPop != null) {
          final allowed = await widget.onWillPop?.call() ?? true;
          if (!allowed) {
            return;
          }
        }

        final hasChanges = widget.hasUnsavedChanges?.call() ?? false;

        if (hasChanges) {
          await showRejectDialog(context, widget.dialogTitle ?? tr('exit_confirm_title'),
              subTitle: widget.dialogSubtitle ?? tr('exit_confirm_subtitle'),
              onConfirm: () => router.pop(),
              type: MyDialogType.warning);
          return;
        }

        if (router.canPop()) {
          router.pop();
        }
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
