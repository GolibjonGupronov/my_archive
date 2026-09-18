import 'package:flutter/cupertino.dart';
import 'package:my_archive/core/enums/common.dart';

class BottomNavItemEntity {
  final String key;
  final Widget page;
  final IconData icon;
  final BottomNavMainPage navItem;

  BottomNavItemEntity(this.key, this.page, this.icon, this.navItem);
}
