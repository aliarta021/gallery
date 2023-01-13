import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/uikit/coming_soon.dart';
import 'package:revolution1401/modules/main/ui/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MainPages {
  // scanQr(LocaleKeys.scanQr_title, Icons.qr_code_scanner_rounded),
  // categories(LocaleKeys.categories_title, Icons.category_rounded),
  search(LocaleKeys.search_title, Icons.search_off_rounded),
  home(LocaleKeys.home_title, Icons.home_rounded),
  gallery(LocaleKeys.gallery_title, Icons.album_rounded);
  // cart(LocaleKeys.cart_title, Icons.shopping_bag_rounded),
  // profile(LocaleKeys.profile_title, Icons.person_rounded);

  const MainPages(this.titleKey, this.icon);
  final String titleKey;
  final IconData icon;
}

final List<Widget> pageWidgets = List<Widget>.from(MainPages.values.map((page) {
  switch (page) {
    case MainPages.search:
      return const Center(child: ComingSoon());
    case MainPages.home:
      return const Center(child: ComingSoon());
    case MainPages.gallery:
      return const Center(child: ComingSoon());
    // case MainPages.scanQr:
    //   return const ScanPage();
    // case MainPages.profile:
    //   return const ProfilePage();
  }
}));

class MainPageBloc extends ChangeNotifier {
  Future checkSeenFirstPage() async {
    final prefs = await SharedPreferences.getInstance();
    bool seenPage = prefs.getBool('seen') ?? false;
    return seenPage;
  }

  int _pageIndex = MainPages.home.index;

  void resetPageIndex() {
    _pageIndex = MainPages.home.index;
    notifyListeners();
  }

  int get pagesCount => pageWidgets.length;

  Widget get page => pageWidgets.elementAt(_pageIndex);

  int get pageIndex => _pageIndex;

  Future<void> changePage(BuildContext context, int index) async {
    // if (!AuthBloc().isLogin && (index == MainPages.profile.index)) {
    //   if (await AuthBloc().canLogin(context)) {
    //     _pageIndex = index;
    //   }
    // } else {
    _pageIndex = index;
    // }
    notifyListeners();
  }
}
