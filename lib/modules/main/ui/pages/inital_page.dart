import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/constants/fonts.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/button/cin_button.dart';
import 'package:revolution1401/common/uikit/switcher.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool isTwoText = false;
  bool isFinalText = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            const SizedBox(
              height: double.infinity,
              child: Image(
                image: AssetImage(Images.initialBackground),
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Switcher(
                switcherAnimation: SwitcherAnimation.fade,
                duration: const Duration(seconds: 2),
                switchInCurve: Curves.easeInCirc,
                child: switchText(),
              ),
            ),
            Switcher(
              switcherAnimation: SwitcherAnimation.fade,
              duration: const Duration(seconds: 4),
              child: isFinalText
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CinButton(
                            borderRadius: BorderRadius.circular(28),
                            type: ButtonType.secondary,
                            color: context.colors.primary,
                            height: 32,
                            onPressed: () async {
                              print('test 1');
                            },
                            child: Text(LocaleKeys.story_title.tr()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: CinButton(
                            color: context.colors.black.withOpacity(0.2),
                            type: ButtonType.secondary,
                            borderRadius: BorderRadius.circular(28),
                            height: 32,
                            onPressed: () async {
                              print('test 2');
                            },
                            child: Text(
                              LocaleKeys.skip.tr(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget switchText() {
    if (!isTwoText && !isFinalText) {
      return AnimatedTextKit(
        onFinished: () {
          setState(() {
            isTwoText = true;
          });
          Timer(const Duration(seconds: 6), () {
            setState(() {
              isTwoText = false;
              isFinalText = true;
            });
          });
        },
        isRepeatingAnimation: false,
        animatedTexts: [
          FadeAnimatedText(
            '${LocaleKeys.initial_movement_title.tr()} \n ${LocaleKeys.iran.tr()}',
            textAlign: TextAlign.center,
            textStyle: context.textTheme.headlineMedium
                ?.copyWith(color: context.colors.scaffoldBackground),
            duration: const Duration(seconds: 5),
          ),
        ],
      );
    } else if (isTwoText) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '${LocaleKeys.women.tr()} ${LocaleKeys.life.tr()} ',
                      style: context.textTheme.headlineMedium
                          ?.copyWith(color: context.colors.background)),
                  TextSpan(
                      text: LocaleKeys.freedom.tr(),
                      style: context.textTheme.headlineMedium
                          ?.copyWith(color: context.colors.primary))
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 68.0),
        child: AnimatedOpacity(
          opacity: isFinalText ? 1.0 : 0,
          duration: const Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.initial_revolution_title.tr(),
                style: context.textTheme.headlineMedium?.copyWith(
                    color: context.colors.background,
                    fontFamily: Fonts.yekanBakhFaNum),
              ),
              Text(
                LocaleKeys.iran.tr(),
                style: context.textTheme.headlineMedium
                    ?.copyWith(color: context.colors.primary),
              )
            ],
          ),
        ),
      );
    }
  }
}
