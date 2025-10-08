import 'package:flutter/material.dart';

class BackButtonHeaderComponent extends StatelessWidget {
  const BackButtonHeaderComponent({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  final String title;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => onBackPressed.call(),
          icon: Icon(Icons.arrow_back),
        ),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
