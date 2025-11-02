import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';
import 'package:minhaserigrafia/shared/model/last_usage_order_enum.dart';

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
      content: Text(message, textAlign: TextAlign.center),
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

Future<void> showLastUsageOrderDialog({
  required Function(LastUsageOrder? selectedOrder) setState,
  required BuildContext context,
  LastUsageOrder? selected,
}) {
  return showDialog<bool>(
    context: context,
    builder: (buildContext) {
      return Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Dialog(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 130,
            child: RadioGroup<LastUsageOrder>(
              groupValue: selected ?? LastUsageOrder.asc,
              onChanged: (LastUsageOrder? selectedOrder) {
                setState(selectedOrder);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Usados recentemente',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: Radio<LastUsageOrder>(value: LastUsageOrder.desc),
                  ),
                  ListTile(
                    title: Text(
                      'Não usados há muito tempo',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: Radio<LastUsageOrder>(value: LastUsageOrder.asc),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
