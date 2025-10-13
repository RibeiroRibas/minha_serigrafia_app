import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

class MenuItemComponent extends StatelessWidget {
  final String title;
  final Icon? icon;
  final String? svgImagePath;
  final Widget? infos;

  const MenuItemComponent({
    super.key,
    required this.title,
    this.icon,
    this.svgImagePath,
    this.infos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ThemeColors.grayLight2, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon!.icon, size: 60, color: icon!.color),
            if (svgImagePath != null)
              SvgPicture.asset(svgImagePath!, width: 60, height: 60),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
