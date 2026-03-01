import 'package:flutter/material.dart';
import 'package:my_archive/core/core_exports.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  static const String tag = '/update_page';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isExitDialog: true,
      appBar: CustomAppBar("Yangi versiya"),
    );
  }
}
