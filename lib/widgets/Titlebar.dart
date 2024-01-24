import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/views/BarcodeScannerView.dart';
import 'package:provider/provider.dart';

class Titlebar extends StatelessWidget {
  final AppBar? appBar;
  final String title;
  final Color bgColor;
  final double barHeight;
  final bool showBack;
  final bool showQR;

  const Titlebar({super.key, 
    required this.title,
    this.appBar,
    this.bgColor = MainApp.color3,
    this.barHeight = kToolbarHeight, //standaard hoogte zonder notch
    this.showBack = true,
    this.showQR = true,
  });

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double minHeight = appBarHeight + statusBarHeight;

    NavigationController navController = Provider.of<NavigationController>(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      child: SizedBox(
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
                automaticallyImplyLeading: showBack,
                centerTitle: true,
                title: Text(
                  title,
                ),
                actions: [
                  if(showQR)
                    Container(
                      padding: EdgeInsets.only(right: 8.0),
                      child:IconButton(
                        iconSize: 32,
                        onPressed: () {
                          
                        navController.gotoPage("qrscan");

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const BarcodeScannerView(),
                        //   ),
                        // );
                        },
                        icon: const Icon(Icons.qr_code_scanner_outlined),
                      ),
                    ),
                  ],
              ),
            ),
          ],
        )
      )
    );
  }
}