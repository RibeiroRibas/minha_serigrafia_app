import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderComponent extends StatelessWidget {
  final Color color;

  const HeaderComponent({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          SvgPicture.asset(
            color == Colors.white
                ? 'assets/images/logo_white.svg'
                : 'assets/images/logo_black.svg',
            height: 58,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              color,  // Força que a cor final seja BRANCA
              BlendMode.srcIn, // Modo de mesclagem para aplicar a cor forçada
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Minha',
                style: TextStyle(
                  fontSize: 32,
                  color: color,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              Text(
                'Serigrafia',
                style: TextStyle(
                  fontSize: 32,
                  color: color,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
