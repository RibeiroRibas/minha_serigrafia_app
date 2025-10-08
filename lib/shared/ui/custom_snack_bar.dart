import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

enum SnackBarType { success, error, info }

void showCustomSnackBar(
  BuildContext context,
  String message, {
  SnackBarType type = SnackBarType.error,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  Color backgroundColor;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = Colors.green;
      break;
    case SnackBarType.error:
      backgroundColor = Colors.red;
      break;
    case SnackBarType.info:
      backgroundColor = ThemeColors.grayLight2;
      break;
  }

  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    action: SnackBarAction(
      label: 'FECHAR',
      textColor: type == SnackBarType.error ? Colors.white : Colors.black,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
