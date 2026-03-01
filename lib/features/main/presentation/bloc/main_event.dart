import 'package:my_archive/core/core_exports.dart';

abstract class MainEvent {}

class InitEvent extends MainEvent {}

class ActiveMainPageEvent extends MainEvent {
  final BottomNavMainPage activePage;

  ActiveMainPageEvent({required this.activePage});
}
