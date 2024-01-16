import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokegrunn/models/MainApp.dart';

Widget NavItem(String svgPath, bool isActive, {VoidCallback? onTap}) {
  Color iconColor = const Color.fromARGB(150, 0, 0, 0);
  Color btnColor = MainApp.color2;
  Color borderColor = const Color.fromARGB(150, 0, 0, 0);

  if(isActive){
    iconColor = const Color.fromARGB(200, 0, 0, 0);
    btnColor = const Color.fromARGB(200, 255, 255, 255);
    borderColor = const Color.fromARGB(200, 0, 0, 0);
  }

  Widget? icon = SvgPicture.asset(
    svgPath,
    height: 40,
    width: 40,
    color: iconColor,
  );
  
  Widget? button = Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: btnColor, // Kleur van de cirkel wanneer geselecteerd
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
    ),
  );

  return IconButton(
    onPressed: onTap,
    padding: EdgeInsets.zero,
    icon: Stack(
      alignment: Alignment.center,
      children: [
        button,
        icon,
      ]
    )
  );

  /*return Padding(
    padding: const EdgeInsets.only(top: 0.0, bottom: 0.0), // Pas de padding hier aan
    child: Stack(
      alignment: Alignment.center,
      children: [
        button,
        icon,
      ]
    )
  );*/
}