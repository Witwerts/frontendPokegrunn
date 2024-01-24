import 'dart:typed_data';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/views/BarcodeScannerView.dart';
import '../models/NavigationPage.dart';

class QRScanPage extends NavigationPage {
  const QRScanPage({super.key});

  @override
  String get routePath => "/qrscan";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => QRScanPageState();
}

class QRScanPageState extends NavigationPageState {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    NavigationController navController =
        Provider.of<NavigationController>(context);
        */

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BarcodeScannerView(),
                ),
              );
            },
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
