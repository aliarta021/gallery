import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revolution1401/common/constants/app_config.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/derafsh_logo.dart';
import 'package:revolution1401/common/uikit/menu/cin_menu.dart';
import 'package:revolution1401/common/utils/locale_helper.dart';
import 'package:revolution1401/modules/map/ui/pages/map_page.dart';

class HeaderSliverWidget extends StatelessWidget {
  const HeaderSliverWidget({required this.searchWidget, Key? key})
      : super(key: key);

  final Widget searchWidget;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        titleSpacing: 12,
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const MapPage()
                  ),
                );
                // context.go(R.main);
              },
              child: const DerafshLogoFa(
                height: 38,
              ),
            ),
            Hero(
              tag: 'changeLocale',
              child: CinMenu<Locale>(
                onSelected: (Locale selectedLocale) {
                  if (selectedLocale != context.locale) {
                    context.setLocale(selectedLocale);
                    GoRouter.of(context).refresh();
                  }
                },
                items: AppConfig.supportedLocales,
                resolveItemText: (Locale locale) => locale.languageName,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.language_rounded,
                        color: ColorPalette.of(context).icon,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        LocaleKeys.language.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: ColorPalette.of(context).icon),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: true,
            title: searchWidget,
          ),
        ),
      );
}
