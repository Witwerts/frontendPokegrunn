import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/AnimationManager.dart';
import 'package:pokegrunn/models/CurvedTween.dart';

class LocationController extends MapControllerImpl {
  final AnimationManager animationManager;

  LocationController(this.animationManager);

  void FlyTo(LatLng newPos, double newZoom, [int duration = 2000, Curve curveType = Curves.easeInBack]) {
    AnimationController controller = animationManager.createController(duration);

    LatLng oldPos = camera.center;
    double oldZoom = camera.zoom;

    Animation<LatLng> latTween = LatLngTween(
      begin: oldPos,
      end: newPos,
    ).animate(controller);

    Animation zoomTween = CurvedTween(
      begin: oldZoom,
      end: newZoom,
      curve: curveType,
    ).animate(controller);

    controller.addListener(() {
      move(latTween.value, zoomTween.value);
    });

    controller.forward().then((value) => controller.dispose());
  }
}