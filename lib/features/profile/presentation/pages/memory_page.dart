import 'package:flutter/material.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/utils/logger.dart';

class MemoryPage extends StatelessWidget {
  static const String tag = '/memory_page';

  const MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    logger("GGQ => MemoryPage");
    return CustomScaffold(
      appBar: CustomAppBar("Xotira"),
      body: ListView(
        children: [],
      ),
    );
  }
}
