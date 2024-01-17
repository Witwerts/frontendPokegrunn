import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';

class Titlebar extends StatelessWidget {
  final AppBar? appBar;
  final String title;
  final Color bgColor;
  final double barHeight;

  Titlebar({
    required this.title,
    this.appBar,
    this.bgColor = MainApp.color3,
    this.barHeight = kToolbarHeight //standaard hoogte zonder notch
  });

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double minHeight = appBarHeight + statusBarHeight;

    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      child: Container(
        height: barHeight > minHeight ? barHeight : minHeight,
        child: Stack(
          children: [
            Container(
              height: barHeight,
              color: bgColor,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: appBar ?? AppBar(
                backgroundColor: bgColor,
                foregroundColor: Colors.white,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  title,
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}