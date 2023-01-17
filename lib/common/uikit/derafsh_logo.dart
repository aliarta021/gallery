import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/switcher.dart';
import 'package:revolution1401/common/utils/locale_helper.dart';

class AnimatedDerafshLogo extends StatefulWidget {
  const AnimatedDerafshLogo({Key? key, this.height, this.color})
      : super(key: key);

  final double? height;
  final Color? color;

  @override
  State<AnimatedDerafshLogo> createState() => _AnimatedDerafshLogoState();
}

class _AnimatedDerafshLogoState extends State<AnimatedDerafshLogo> {
  bool toggle = true;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            toggle = !toggle;
          });
        },
        child: Switcher(
          duration: const Duration(milliseconds: 120),
          child: toggle
              ? DerafshLogoEn(color: widget.color)
              : DerafshLogoFa(color: widget.color),
        ),
      );
}

class DerafshLogoEn extends StatelessWidget {
  const DerafshLogoEn(
      {Key? key, this.height = 48, this.color, this.spaceBetween})
      : super(key: key);

  final double height;
  final Color? color;
  final double? spaceBetween;

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'derafshLogoEn',
        child: Material(
          type: MaterialType.transparency,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SvgPicture.asset(Svgs.logo,
                    color: color ?? ColorPalette.of(context).primary,
                    height: height),
                SizedBox(width: spaceBetween ?? height / 6),
                SvgPicture.asset(Svgs.logoTypeEn,
                    color: color ?? ColorPalette.of(context).primary,
                    height: height / 1.3),
              ]),
        ),
      );
}

class DerafshLogoFa extends StatelessWidget {
  const DerafshLogoFa(
      {Key? key, this.height = 48, this.color, this.spaceBetween})
      : super(key: key);

  final double height;
  final Color? color;
  final double? spaceBetween;

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'derafshLogoFa',
        child: Material(
          type: MaterialType.transparency,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SvgPicture.asset(Svgs.logo,
                      // color: color ?? ColorPalette.of(context).primary,
                      height: height),
                ),
                SizedBox(width: spaceBetween ?? height / 6),
                // SvgPicture.asset(Svgs.logo,
                //     color: color ?? ColorPalette.of(context).primary,
                //     height: height / 1.3),
              ]),
        ),
      );
}

class PaybuyLogo extends StatelessWidget {
  const PaybuyLogo({Key? key, this.height = 48, this.color, this.spaceBetween})
      : super(key: key);

  final double height;
  final Color? color;
  final double? spaceBetween;

  @override
  Widget build(BuildContext context) => context.isFa
      ? DerafshLogoFa(
          height: height,
          color: color,
          spaceBetween: spaceBetween,
        )
      : DerafshLogoEn(
          height: height,
          color: color,
          spaceBetween: spaceBetween,
        );
}
