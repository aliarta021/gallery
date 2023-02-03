import 'package:flutter/material.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/utils/hero_hash.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';
import 'package:separated_column/separated_column.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(
      {required this.title,
      Key? key,
      this.subtitle,
      this.titleStyle,
      this.subtitleStyle,
      this.padding,
      this.descriptionWidget,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.titleHeroTag,
      this.subtitleHeroTag})
      : super(key: key);

  factory TitleWidget.fromSlider(
    BannerModel slider,
          {TextStyle? titleStyle,
          TextStyle? subtitleStyle,
          EdgeInsetsGeometry? padding = EdgeInsets.zero,
          Widget? descriptionWidget}) =>
      TitleWidget(
        title: 'slider.title?.tr()',
        subtitle: 'slider.subtitle?.tr()',
        titleStyle: titleStyle,
        subtitleStyle: subtitleStyle,
        padding: padding,
        descriptionWidget: descriptionWidget,
      );

  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? padding;
  final Widget? descriptionWidget;
  final CrossAxisAlignment crossAxisAlignment;
  final String? titleHeroTag;
  final String? subtitleHeroTag;

  @override
  Widget build(BuildContext context) => ((title ?? '').trim().isEmpty && (subtitle ?? '').trim().isEmpty)
      ? const SizedBox.shrink()
      : SizedBox(
          width: double.infinity,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: SeparatedColumn(
              crossAxisAlignment: crossAxisAlignment,
              children: <Widget>[
                if ((title ?? '') != '')
                  Hero(
                    tag: HeroHash.fromString(title, tag: titleHeroTag),
                    child: Text(
                      title ?? '',
                      style: titleStyle ?? Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                if ((subtitle ?? '') != '')
                  Hero(
                    tag: HeroHash.fromString(subtitle, tag: subtitleHeroTag),
                    child: Text(subtitle!, style: subtitleStyle ?? context.textTheme.subtitle2),
                  ),
                if (descriptionWidget != null) descriptionWidget!,
              ],
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          ),
        );
}
