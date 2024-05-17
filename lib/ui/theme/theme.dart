import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281887036),
      surfaceTint: Color(4281887036),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4290375863),
      onPrimaryContainer: Color(4278198534),
      secondary: Color(4283589456),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292143312),
      onSecondaryContainer: Color(4279246608),
      tertiary: Color(4281951595),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290571250),
      onTertiaryContainer: Color(4278198051),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294441970),
      onBackground: Color(4279770392),
      surface: Color(4294441970),
      onSurface: Color(4279770392),
      surfaceVariant: Color(4292797913),
      onSurfaceVariant: Color(4282534208),
      outline: Color(4285692271),
      outlineVariant: Color(4290955709),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281152044),
      inverseOnSurface: Color(4293849833),
      inversePrimary: Color(4288599197),
      primaryFixed: Color(4290375863),
      onPrimaryFixed: Color(4278198534),
      primaryFixedDim: Color(4288599197),
      onPrimaryFixedVariant: Color(4280307750),
      secondaryFixed: Color(4292143312),
      onSecondaryFixed: Color(4279246608),
      secondaryFixedDim: Color(4290366645),
      onSecondaryFixedVariant: Color(4282010425),
      tertiaryFixed: Color(4290571250),
      onTertiaryFixed: Color(4278198051),
      tertiaryFixedDim: Color(4288794326),
      onTertiaryFixedVariant: Color(4280241491),
      surfaceDim: Color(4292336595),
      surfaceBright: Color(4294441970),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294047212),
      surfaceContainer: Color(4293652454),
      surfaceContainerHigh: Color(4293323233),
      surfaceContainerHighest: Color(4292928731),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279979043),
      surfaceTint: Color(4281887036),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283334736),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281747253),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284971365),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279912783),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283399298),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294441970),
      onBackground: Color(4279770392),
      surface: Color(4294441970),
      onSurface: Color(4279770392),
      surfaceVariant: Color(4292797913),
      onSurfaceVariant: Color(4282271036),
      outline: Color(4284113240),
      outlineVariant: Color(4285955443),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281152044),
      inverseOnSurface: Color(4293849833),
      inversePrimary: Color(4288599197),
      primaryFixed: Color(4283334736),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281755194),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284971365),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283392078),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283399298),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281754473),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336595),
      surfaceBright: Color(4294441970),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294047212),
      surfaceContainer: Color(4293652454),
      surfaceContainerHigh: Color(4293323233),
      surfaceContainerHighest: Color(4292928731),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278200585),
      surfaceTint: Color(4281887036),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4279979043),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279641623),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281747253),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200107),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4279912783),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294441970),
      onBackground: Color(4279770392),
      surface: Color(4294441970),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292797913),
      onSurfaceVariant: Color(4280231454),
      outline: Color(4282271036),
      outlineVariant: Color(4282271036),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281152044),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4291033792),
      primaryFixed: Color(4279979043),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278203662),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281747253),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280365344),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4279912783),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202936),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336595),
      surfaceBright: Color(4294441970),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294047212),
      surfaceContainer: Color(4293652454),
      surfaceContainerHigh: Color(4293323233),
      surfaceContainerHighest: Color(4292928731),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4288599197),
      surfaceTint: Color(4288599197),
      onPrimary: Color(4278466834),
      primaryContainer: Color(4280307750),
      onPrimaryContainer: Color(4290375863),
      secondary: Color(4290366645),
      onSecondary: Color(4280562724),
      secondaryContainer: Color(4282010425),
      onSecondaryContainer: Color(4292143312),
      tertiary: Color(4288794326),
      onTertiary: Color(4278203964),
      tertiaryContainer: Color(4280241491),
      onTertiaryContainer: Color(4290571250),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279243792),
      onBackground: Color(4292928731),
      surface: Color(4279243792),
      onSurface: Color(4292928731),
      surfaceVariant: Color(4282534208),
      onSurfaceVariant: Color(4290955709),
      outline: Color(4287402889),
      outlineVariant: Color(4282534208),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928731),
      inverseOnSurface: Color(4281152044),
      inversePrimary: Color(4281887036),
      primaryFixed: Color(4290375863),
      onPrimaryFixed: Color(4278198534),
      primaryFixedDim: Color(4288599197),
      onPrimaryFixedVariant: Color(4280307750),
      secondaryFixed: Color(4292143312),
      onSecondaryFixed: Color(4279246608),
      secondaryFixedDim: Color(4290366645),
      onSecondaryFixedVariant: Color(4282010425),
      tertiaryFixed: Color(4290571250),
      onTertiaryFixed: Color(4278198051),
      tertiaryFixedDim: Color(4288794326),
      onTertiaryFixedVariant: Color(4280241491),
      surfaceDim: Color(4279243792),
      surfaceBright: Color(4281743924),
      surfaceContainerLowest: Color(4278914827),
      surfaceContainerLow: Color(4279770392),
      surfaceContainer: Color(4280033563),
      surfaceContainerHigh: Color(4280757030),
      surfaceContainerHighest: Color(4281415216),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4288862369),
      surfaceTint: Color(4288599197),
      onPrimary: Color(4278196997),
      primaryContainer: Color(4285177195),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290629817),
      onSecondary: Color(4278852107),
      secondaryContainer: Color(4286813824),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4289057754),
      onTertiary: Color(4278196765),
      tertiaryContainer: Color(4285307039),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279243792),
      onBackground: Color(4292928731),
      surface: Color(4279243792),
      onSurface: Color(4294507763),
      surfaceVariant: Color(4282534208),
      onSurfaceVariant: Color(4291218882),
      outline: Color(4288587162),
      outlineVariant: Color(4286481787),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928731),
      inverseOnSurface: Color(4280757030),
      inversePrimary: Color(4280373799),
      primaryFixed: Color(4290375863),
      onPrimaryFixed: Color(4278195715),
      primaryFixedDim: Color(4288599197),
      onPrimaryFixedVariant: Color(4278992663),
      secondaryFixed: Color(4292143312),
      onSecondaryFixed: Color(4278588423),
      secondaryFixedDim: Color(4290366645),
      onSecondaryFixedVariant: Color(4280957481),
      tertiaryFixed: Color(4290571250),
      onTertiaryFixed: Color(4278195223),
      tertiaryFixedDim: Color(4288794326),
      onTertiaryFixedVariant: Color(4278729794),
      surfaceDim: Color(4279243792),
      surfaceBright: Color(4281743924),
      surfaceContainerLowest: Color(4278914827),
      surfaceContainerLow: Color(4279770392),
      surfaceContainer: Color(4280033563),
      surfaceContainerHigh: Color(4280757030),
      surfaceContainerHighest: Color(4281415216),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4293984235),
      surfaceTint: Color(4288599197),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4288862369),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293984235),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290629817),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294049279),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4289057754),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279243792),
      onBackground: Color(4292928731),
      surface: Color(4279243792),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282534208),
      onSurfaceVariant: Color(4294376945),
      outline: Color(4291218882),
      outlineVariant: Color(4291218882),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928731),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278202893),
      primaryFixed: Color(4290704827),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4288862369),
      onPrimaryFixedVariant: Color(4278196997),
      secondaryFixed: Color(4292472020),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290629817),
      onSecondaryFixedVariant: Color(4278852107),
      tertiaryFixed: Color(4290899958),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4289057754),
      onTertiaryFixedVariant: Color(4278196765),
      surfaceDim: Color(4279243792),
      surfaceBright: Color(4281743924),
      surfaceContainerLowest: Color(4278914827),
      surfaceContainerLow: Color(4279770392),
      surfaceContainer: Color(4280033563),
      surfaceContainerHigh: Color(4280757030),
      surfaceContainerHighest: Color(4281415216),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
