import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

ThemeData defaultTheme = ThemeData(
  dialogTheme: DialogThemeData(
    backgroundColor: ThemeColors.grayLight,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 8,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      overflow: TextOverflow.fade,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 16,
      color: Colors.black,
      overflow: TextOverflow.fade,
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeColors.blueDark,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.white),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Colors.red,
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    elevation: 6,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  scaffoldBackgroundColor: ThemeColors.grayLight,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: ThemeColors.grayLight,
    onSecondary: Colors.white,
    tertiary: ThemeColors.grayLight,
    onTertiary: ThemeColors.grayLight2,
    error: Colors.red,
    onError: Colors.white,
    surface: ThemeColors.blueDark,
    onSurface: Colors.white,
    surfaceContainerHighest: ThemeColors.grayLight2,
    onSurfaceVariant: ThemeColors.grayLight3,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.fade,
    ),
    titleMedium: TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.fade,
    ),
    titleSmall: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.fade,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.fade,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      overflow: TextOverflow.fade,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Colors.black,
      overflow: TextOverflow.fade,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      minimumSize: const Size(double.infinity, 60),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      disabledBackgroundColor: ThemeColors.grayLight2,
      disabledForegroundColor: ThemeColors.grayLight3,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        overflow: TextOverflow.fade,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: ThemeColors.grayLight2, width: 2),
      minimumSize: const Size(double.infinity, 60),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      elevation: 0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: ThemeColors.blueDark,
    unselectedItemColor: ThemeColors.grayLight,
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      overflow: TextOverflow.fade,
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      overflow: TextOverflow.fade,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        overflow: TextOverflow.fade,
      ),
      foregroundColor: ThemeColors.grayDark,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: InputDecorationTheme(
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 12,
      overflow: TextOverflow.fade,
    ),
    labelStyle: const TextStyle(
      color: ThemeColors.grayLight2,
      fontSize: 16,
      overflow: TextOverflow.fade,
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.black, // Focused label color
      fontSize: 16,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.fade,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ThemeColors.grayLight2, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.black, // Set your desired focus color
        width: 2.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 2.0),
    ),
  ),
  dividerTheme: const DividerThemeData(color: ThemeColors.grayLight3),
  fontFamily: 'Roboto',
);
