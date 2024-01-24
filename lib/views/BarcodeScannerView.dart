import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/pages/QRScanPage.dart';
import 'package:pokegrunn/widgets/scanner_error_widget.dart';
import 'package:pokegrunn/widgets/Confetti.dart';

import 'package:provider/provider.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 5000,
    // returnImage: false,
  );

  bool hasBeenScannedSuccessfully = false;
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

  void barcodeDetected(ConfettiController confettiController) async {
    AccountController accountController =
        Provider.of<AccountController>(context, listen: false);
    AchievementController achievementController =
        Provider.of<AchievementController>(context, listen: false);

    bool success = false;
    String message = '';

    (success, message) = await achievementController.registerAchievementToUser(
        accountController.username!, (barcode?.barcodes.first.rawValue)!);

    if (success && !hasBeenScannedSuccessfully) {
      setState(() {
        hasBeenScannedSuccessfully = true;
      });
      confettiController.play();

      showAlertDialog(context, "Achievement behaald!");

      //print("Achievement is behaald");
      close();
    } else {
      print("Er is iets mis gegaan: $message");
    }
  }

  showAlertDialog(BuildContext context, String text) {
    NavigationController navigationController =
        Provider.of<NavigationController>(context, listen: false);

    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(text),
      //content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((val) {
      navigationController.resetTab(navigationController.tabIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    ConfettiController confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    Widget confetti = Confetti(confettiController: confettiController);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                fit: BoxFit.contain,
                onDetect: (barcode) {
                  setState(() {
                    this.barcode = barcode;
                    barcodeDetected(confettiController);
                  });
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  alignment: Alignment.topCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
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
                      /* Stop en Start button
                      IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: _startOrStop,
                      ),*/

                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 100,
                          child: FittedBox(
                              /*child: Text(
                              barcode?.barcodes.first.rawValue ??
                                  'Scan something!',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),*/
                              ),
                        ),
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
              confetti,
            ],
          );
        },
      ),
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
