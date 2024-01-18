import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokegrunn/models/MainApp.dart';

Widget NavItem(String svgPath, String title, bool isActive, {VoidCallback? onTap}) {
  Color color = const Color.fromARGB(150, 0, 0, 0);

  if(isActive){
    color = MainApp.color2;
  }

  return Material(
    color: Colors.transparent, // Stel een achtergrondkleur in indien nodig
    child: Ink(
      child: InkWell(
        onTap: onTap,
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)), // Zorgt voor een strak vierkant zonder afronding
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
          width: 68,
          child: Column(
            children: [
              Align (
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  svgPath,
                  height: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]
          ),
        ), // Vervang 'your_icon' door het gewenste icoon
        ),
      ),
    ),
  );
}