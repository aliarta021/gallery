import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revolution1401/common/constants/fonts.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Fonts.yekanBakh,
    brightness: Brightness.light,
    primaryColor: ColorPalette.light.primary,
    splashColor: ColorPalette.light.splash,
    highlightColor: Colors.transparent,
    backgroundColor: ColorPalette.light.background,
    canvasColor: ColorPalette.light.background,
    scaffoldBackgroundColor: ColorPalette.light.scaffoldBackground,
    errorColor: ColorPalette.light.error,
    dividerColor: ColorPalette.light.divider,
    toggleableActiveColor: ColorPalette.light.primary,
    shadowColor: ColorPalette.light.shadow,
    hintColor: ColorPalette.light.textSecondary,
    disabledColor: ColorPalette.light.disabled,
    primaryColorDark: ColorPalette.light.primary.dark,
    primaryColorLight: ColorPalette.light.primary.light,
    cardColor: ColorPalette.light.scaffoldBackground,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalette.light.cursor,
      selectionHandleColor: ColorPalette.light.primary,
      selectionColor: ColorPalette.light.textSelectionColor,
    ),
    dividerTheme: DividerThemeData(color: ColorPalette.light.divider, thickness: 1.5, space: 0),
    //! AppBar
    appBarTheme: AppBarTheme(
      elevation: 4,
      shadowColor: ColorPalette.light.toolbarShadow,
      color: ColorPalette.light.scaffoldBackground,
      iconTheme: IconThemeData(color: ColorPalette.light.textPrimary, size: 18),
      actionsIconTheme: IconThemeData(color: ColorPalette.light.textPrimary),
      titleTextStyle: TextTheme(
        headline6: Typography.englishLike2018.subtitle2!.copyWith(
            height: 1.5,
            letterSpacing: 0,
            color: ColorPalette.light.textPrimary,
            fontFamily: Fonts.yekanBakh,
            fontWeight: FontWeight.w900),
      ).headline6,
      titleSpacing: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    iconTheme: IconThemeData(color: ColorPalette.light.textSecondary),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: ColorPalette.light.textSecondary,
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: Fonts.yekanBakh,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: Fonts.yekanBakh,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorPalette.light.background,
    ),
    //!button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorPalette.light.primary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shadowColor: MaterialStateProperty.all(ColorPalette.light.primary.withOpacity(0.6)),
        overlayColor: MaterialStateProperty.all(ColorPalette.light.splash),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) => ColorPalette.light.primary),
      backgroundColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) => ColorPalette.light.scaffoldBackground),
      overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) => ColorPalette.light.splash),
      elevation: MaterialStateProperty.all(0),
    )),
    //! Texts
    textTheme: TextTheme(
      overline: Typography.englishLike2018.overline!.copyWith(
        fontSize: 12,
        color: ColorPalette.light.textSecondary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.5,
      ),
      caption: Typography.englishLike2018.caption!.copyWith(
        fontSize: 10,
        color: ColorPalette.light.textPrimary,
        height: 1.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      button: Typography.englishLike2018.button!.copyWith(
        fontSize: 14,
        color: Colors.white,
        height: 1.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      bodyText2: Typography.englishLike2018.bodyText2!.copyWith(
        fontSize: 12,
        color: ColorPalette.light.textPrimary,
        height: 1.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      bodyText1: Typography.englishLike2018.bodyText1!.copyWith(
        fontSize: 14,
        color: ColorPalette.light.textPrimary,
        height: 1.5,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      subtitle2: Typography.englishLike2018.subtitle2!.copyWith(
        fontSize: 13,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0,
      ),
      subtitle1: Typography.englishLike2018.subtitle1!.copyWith(
        fontSize: 16,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0,
      ),
      headline1: Typography.englishLike2018.headline1!.copyWith(
        fontSize: 96,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        // fontWeight: FontWeight.w500,
      ),
      headline2: Typography.englishLike2018.headline2!.copyWith(
        fontSize: 60,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
      ),
      headline3: Typography.englishLike2018.headline3!.copyWith(
        fontSize: 48,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0,
      ),
      headline4: Typography.englishLike2018.headline4!.copyWith(
        fontSize: 34,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0,
      ),
      headline5: Typography.englishLike2018.headline5!.copyWith(
        fontSize: 24,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0,
      ),
      headline6: Typography.englishLike2018.headline6!.copyWith(
        fontSize: 20,
        color: ColorPalette.light.textPrimary,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: 0,
      ),
    ).apply(), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorPalette.light.primary),
  );
}
