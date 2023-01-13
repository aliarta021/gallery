import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';


class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key, this.title, this.description}) : super(key: key);

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [ColorPalette.of(context).primary, ColorPalette.of(context).primary.light])),
              padding: const EdgeInsets.all(15),
              child: Icon(Icons.timer, color: ColorPalette.of(context).white, size: 30)),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Text(title ?? LocaleKeys.common_comingSoon.tr(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w900)),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Text(
                description!,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
        ]),
      );
}
