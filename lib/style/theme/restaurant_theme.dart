import 'package:flutter/material.dart';

class RestaurantTheme {
  final TextTheme textTheme;

  const RestaurantTheme(this.textTheme);

  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }

  ThemeData light() => theme(lightScheme());

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff73000a),
      surfaceTint: Color(0xffbf0419),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd51f26),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff483200),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff87682b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff273c00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff517800),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff73001a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda003a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff1c0d0c),
      onSurfaceVariant: Color(0xff4a2f2d),
      outline: Color(0xff694b48),
      outlineVariant: Color(0xff866562),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3f2c2a),
      inversePrimary: Color(0xffffb3ac),
      primaryFixed: Color(0xffd51f26),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffae0015),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff87682b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6c5015),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff517800),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3f5e00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdec0bc),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xffffe2de),
      surfaceContainerHigh: Color(0xfff5d6d2),
      surfaceContainerHighest: Color(0xffeacbc7),
    );
  }

  ThemeData dark() => theme(darkScheme());

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2cd),
      surfaceTint: Color(0xffffb3ac),
      onPrimary: Color(0xff540005),
      primaryContainer: Color(0xffff544e),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffe8c2),
      onSecondary: Color(0xff402c00),
      secondaryContainer: Color(0xfff0c982),
      onSecondaryContainer: Color(0xff4f3700),
      tertiary: Color(0xffc7fa75),
      onTertiary: Color(0xff213400),
      tertiaryContainer: Color(0xffacdd5c),
      onTertiaryContainer: Color(0xff2b4100),
      error: Color(0xffffd1d1),
      onError: Color(0xff530010),
      errorContainer: Color(0xffff5263),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1f0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffdd3ce),
      outline: Color(0xffd0a9a5),
      outlineVariant: Color(0xffac8884),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffbdbd8),
      inversePrimary: Color(0xff950010),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff2d0001),
      primaryFixedDim: Color(0xffffb3ac),
      onPrimaryFixedVariant: Color(0xff73000a),
      secondaryFixed: Color(0xffffdea5),
      onSecondaryFixed: Color(0xff190f00),
      secondaryFixedDim: Color(0xffe7c17b),
      onSecondaryFixedVariant: Color(0xff483200),
      tertiaryFixed: Color(0xffc0f36f),
      onTertiaryFixed: Color(0xff0a1400),
      tertiaryFixedDim: Color(0xffa5d656),
      onTertiaryFixedVariant: Color(0xff273c00),
      surfaceDim: Color(0xff1f0f0e),
      surfaceBright: Color(0xff553f3d),
      surfaceContainerLowest: Color(0xff110404),
      surfaceContainerLow: Color(0xff2a1917),
      surfaceContainer: Color(0xff362321),
      surfaceContainerHigh: Color(0xff412e2c),
      surfaceContainerHighest: Color(0xff4d3936),
    );
  }
}
