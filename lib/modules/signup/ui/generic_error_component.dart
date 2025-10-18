import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

class GenericErrorComponent extends StatelessWidget {
  final VoidCallback onRetry;
  final int errorCode;

  const GenericErrorComponent({
    super.key,
    required this.onRetry,
    required this.errorCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'Ocorreu um erro inesperado.\nPor favor, tente novamente.',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 8),
            IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () => onRetry.call(),
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        Text(
          'Código: $errorCode',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: ThemeColors.grayLight3),
        ),
      ],
    );
  }
}
