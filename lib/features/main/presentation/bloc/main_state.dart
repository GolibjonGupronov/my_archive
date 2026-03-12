import 'package:my_archive/core/core_exports.dart';

class MainState {
  final BottomNavMainPage activePage;

  MainState({
    this.activePage = BottomNavMainPage.home,
  });

  MainState copyWith({
    BottomNavMainPage? activePage,
  }) =>
      MainState(
        activePage: activePage ?? this.activePage,
      );
}
