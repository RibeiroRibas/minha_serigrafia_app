import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

Future<void> confirmAction({
  required BuildContext context,
  required VoidCallback onConfirm,
  required String message,
}) async {
  final theme = Theme.of(context);
  await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: ThemeColors.grayLight2,
      title: Icon(Icons.warning_amber_rounded, color: theme.colorScheme.error),
      content: Text(message,textAlign: TextAlign.center,),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          onPressed: () {
            onConfirm.call();
            Navigator.of(dialogContext).pop(false);
          },
          child: const Text('Confirmar'),
        ),
      ],
    ),
  );
}
