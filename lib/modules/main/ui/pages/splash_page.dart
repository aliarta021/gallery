import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/animated_condition.dart';
import 'package:revolution1401/common/utils/status_bar.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) => Material(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: StatusBar.whiteTransparent(context),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const <double>[
                  0.2,
                  1
                ],
                    colors: <Color>[
                  ColorPalette.of(context).primary.background,
                  ColorPalette.of(context).scaffoldBackground
                ])),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ZoomIn(
                  child: DoughRecipe(
                    data: DoughRecipeData(
                      entryDuration: const Duration(milliseconds: 200),
                      adhesion: 2,
                      viscosity: 15000,
                      usePerspectiveWarp: true,
                      exitDuration: const Duration(milliseconds: 1100),
                    ),
                    child: PressableDough(
                      // todo: logo app
                      child: Container(),
                    ),
                  ),
                ),
                AnimatedCondition(
                  child != null,
                  duration: const Duration(milliseconds: 450),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
