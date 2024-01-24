import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/AnimationManager.dart';
import 'package:pokegrunn/models/CurvedTween.dart';

import 'package:vector_math/vector_math.dart';

class LocationController extends MapControllerImpl {
  final AnimationManager animationManager;

  LocationController(this.animationManager);

  static double calcDistance(LatLng start, LatLng end){
    double R = 6371;

    double dlat = radians(end.latitude - start.latitude);
    double dlon = radians(end.longitude - end.latitude);

    double a = sin(dlat / 2) * sin(dlat / 2) + cos(radians(end.latitude)) * cos(radians(start.latitude)) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double d = R * c;

    return d; 
  }

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