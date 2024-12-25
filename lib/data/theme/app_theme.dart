import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prodigal/data/theme/custom_theme_extensions.dart';

class AppTheme {
  static const font = 'Nunito';
  static final TextTheme _textTheme = TextTheme(
    titleLarge: TextStyle(
      fontFamily: font,
      fontSize: 30.sp,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 20.sp,
      fontFamily: font,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: const TextStyle(fontFamily: font),
  );

  static final TextTheme _textThemeDark = TextTheme(
    titleLarge: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: font,
    ),
    titleMedium: TextStyle(
      fontSize: 20.sp,
      fontFamily: font,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontFamily: font,
    ),
  );

  static ThemeData get light => FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff004881),
          primaryContainer: Color(0xffd0e4ff),
          secondary: Color(0xffac3306),
          secondaryContainer: Color(0xffffdbcf),
          tertiary: Color(0xff006875),
          tertiaryContainer: Color(0xff95f0ff),
          appBarColor: Color(0xffffdbcf),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        textTheme: _textTheme,
        extensions: [
          CustomThemeExtension(),
        ],
      );

  static ThemeData get dark => FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff9fc9ff),
          primaryContainer: Color(0xff00325b),
          secondary: Color(0xffffb59d),
          secondaryContainer: Color(0xff872100),
          tertiary: Color(0xff86d2e1),
          tertiaryContainer: Color(0xff004e59),
          appBarColor: Color(0xff872100),
          error: Color(0xffcf6679),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        textTheme: _textThemeDark,
        extensions: [
          CustomThemeExtension(),
        ],
      );
}
