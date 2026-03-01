import 'package:flutter/cupertino.dart';
import 'package:my_archive/core/core_exports.dart';

class BottomNavItemEntity {
  final String title;
  final Widget page;
  final IconData icon;
  final BottomNavMainPage navItem;

  BottomNavItemEntity(this.title, this.page, this.icon, this.navItem);
}
