import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPage.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:pokegrunn/widgets/scanner_error_widget.dart';

import 'package:provider/provider.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';

class BarcodeScannerView extends NavigationPage {
  const BarcodeScannerView({super.key});

  @override
  bool get showNavigation => false;

  @override
  NavigationPageState createState() =>
      _BarcodeScannerViewState();
}

class _BarcodeScannerViewState
    extends NavigationPageState<BarcodeScannerView> {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 1000,
    // returnImage: false,
  );

  bool isStarted = true;

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void barcodeDetected() async {
    AccountController accountController=
        Provider.of<AccountController>(context, listen: false);
    AchievementController achievementController =
        Provider.of<AchievementController>(context, listen: false);
    NavigationController navigationController =
        Provider.of<NavigationController>(context, listen: false);

    bool success = false;
    String message = '';

    (success, message) = await achievementController.registerAchievementToUser(
        accountController.username!, (barcode?.barcodes.first.rawValue)!);

    if (success) {
      print("achievement is geregistreerd!");

      //await Future.delayed(Duration(seconds: 3));

      navigationController.resetTab(navigationController.tabIndex);
      
      close();
      //navigationController.switchTab(navigationController.tabIndex);
    } else {
      print("Er is iets mis gegaan: $message");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Titlebar(
          title: "Scanner",
          barHeight: 130,
          showBack: true,
          showQR: false,
        ),
        BoxContainer (
          margin: EdgeInsets.fromLTRB(20, 80, 20, 105),
          padding: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  errorBuilder: (context, error, child) {
                    return ScannerErrorWidget(error: error);
                  },
                  fit:BoxFit.cover,
                  onDetect: (barcode) {
                    setState(() {
                      this.barcode = barcode;
                      barcodeDetected();
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: controller.hasTorchState,
                          builder: (context, state, child) {
                            if (state != true) {
                              return const SizedBox.shrink();
                            }
                            return IconButton(
                              color: Colors.white,
                              icon: ValueListenableBuilder<TorchState>(
                                valueListenable: controller.torchState,
                                builder: (context, state, child) {
                                  switch (state) {
                                    case TorchState.off:
                                      return const Icon(
                                        Icons.flash_off,
                                        color: Colors.grey,
                                      );
                                    case TorchState.on:
                                      return const Icon(
                                        Icons.flash_on,
                                        color: Colors.yellow,
                                      );
                                  }
                                },
                              ),
                              iconSize: 32.0,
                              onPressed: () => controller.toggleTorch(),
                            );
                          },
                        ),

                        //Camera Flip button
                        IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder<CameraFacing>(
                            valueListenable: controller.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state) {
                                case CameraFacing.front:
                                  return const Icon(Icons.camera_front);
                                case CameraFacing.back:
                                  return const Icon(Icons.camera_rear);
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () => controller.switchCamera(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> close() async {
    await controller.stop();
    controller.dispose();
  }

  @override
  void dispose() async {
    close();

    super.dispose();
  }
}
