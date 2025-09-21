import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

ThemeData defaultTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeColors.blueDark,
    surfaceTintColor: Colors.transparent,
  ),
  drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.white),
  scaffoldBackgroundColor: ThemeColors.grayLight,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.black,
    secondary: ThemeColors.grayDark,
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
      bodyLarge: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.fade),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16, overflow: TextOverflow.fade),
      bodySmall: TextStyle(
          fontSize: 12, color: Colors.black, overflow: TextOverflow.fade),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minimumSize: const Size(double.infinity, 60),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: ThemeColors.grayLight3, width: 2),
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
        overflow: TextOverflow.fade),
    selectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.fade),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade),
      foregroundColor: ThemeColors.grayDark,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: InputDecorationTheme(

    labelStyle: const TextStyle(
        color: ThemeColors.grayLight2, fontSize: 16, overflow: TextOverflow.fade),
    floatingLabelStyle: const TextStyle(
      color: Colors.black, // Focused label color
      fontSize: 16,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.fade,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: ThemeColors.grayLight2,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.black, // Set your desired focus color
        width: 2.0,
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(color: ThemeColors.grayLight3),
  fontFamily: 'Roboto',
);
