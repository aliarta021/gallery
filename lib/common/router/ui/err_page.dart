import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/button/cin_button.dart';
import 'package:revolution1401/common/uikit/page/cin_page.dart';

class ErrPage extends StatelessWidget {
  const ErrPage({Key? key, this.title, this.description}) : super(key: key);

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) => CinPage(
        title: title ?? LocaleKeys.errPage_title.tr(),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: [
                SvgPicture.asset(
                  Svgs.logo,
                  width: 70,
                  color: context.colors.textDisabled,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    description ?? LocaleKeys.errPage_description.tr(),
                    style: context.theme.textTheme.subtitle2!.copyWith(color: context.colors.textCaption),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CinButton(
                    onPressed: () async {
                      context.pop();
                    },
                    width: 100,
                    type: ButtonType.secondary,
                    text: LocaleKeys.errPage_goBack.tr(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
