import 'package:my_archive/core/exports/core_exports.dart';

abstract class MainEvent {}

class InitEvent extends MainEvent {}

class ActiveMainPageEvent extends MainEvent {
  final BottomNavMainPage activePage;

  ActiveMainPageEvent({required this.activePage});
}

class WatchSessionEvent extends MainEvent {}

class SessionExpiredEvent extends MainEvent {}
