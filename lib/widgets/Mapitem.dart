import 'package:flutter/material.dart';
import 'package:pokegrunn/models/AchievementModel.dart';

class MapItemController with ChangeNotifier {
  bool showDetails = false;

  void openDetails() {
    showDetails = true;
    notifyListeners();
  }

  void closeDetails() {
    showDetails = false;
    notifyListeners();
  }
}

class MapItem extends StatefulWidget {
  const MapItem({Key? key, required this.achievement}) : super(key: key);

  final AchievementModel achievement;

  @override
  State<StatefulWidget> createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> {
  late MapItemController controller;
  late OverlayEntry overlayEntry;
  late RenderBox markerRenderBox;

  @override
  void initState() {
    super.initState();
    controller = MapItemController();
  }

  // Build the overlay content
  Widget buildOverlay() {
    AchievementModel achievement = widget.achievement;
    final markerPosition = markerRenderBox.localToGlobal(Offset.zero);

    final double maxTop = MediaQuery.of(context).size.height - 150;
    final double minTop = 0;
    final double maxLeft = MediaQuery.of(context).size.width - 250;
    final double minLeft = 0;

    double top = (markerPosition.dy - 150).clamp(minTop, maxTop);
    double left = (markerPosition.dx - 125).clamp(minLeft, maxLeft);

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              controller.closeDetails();
              overlayEntry.remove();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          top: top,
          left: left,
          child: Material(
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.name ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Points: ${achievement.points ?? 0}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    achievement.description ?? "",
                    maxLines: 10,
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.closeDetails();
                      overlayEntry.remove();
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) => buildOverlay(),
    );

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            markerRenderBox = context.findRenderObject() as RenderBox;
            if (!controller.showDetails) {
              Overlay.of(context).insert(overlayEntry);
            }
            controller.openDetails();
          },
          icon: const Icon(
            Icons.location_on,
            size: 60,
            color: Colors.white,
            shadows: [Shadow(offset: Offset(2.0, 2.0))],
          ),
        ),
        if (controller.showDetails) buildOverlay(),
      ],
    );
  }
}