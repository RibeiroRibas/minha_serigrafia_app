import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

class PrimaryContainerComponent extends StatelessWidget {
  final Widget child;

  const PrimaryContainerComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ThemeColors.grayLight2, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: child,
      ),
    );
  }
}
