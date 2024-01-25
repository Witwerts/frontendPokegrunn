import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/DataManager.dart';
import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';

import 'package:pokegrunn/models/UserModel.dart';
import 'package:vector_math/vector_math_64.dart';

class LocationService {
  Timer? listenTimer;

  double calcDistance(LatLng start, LatLng end){
    double R = 6371;

    double dlat = radians(end.latitude - start.latitude);
    double dlon = radians(end.longitude - start.longitude);

    double a = sin(dlat / 2) * sin(dlat / 2) + cos(radians(end.latitude)) * cos(radians(start.latitude)) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double d = R * c;

    print(d);

    return d; 
  }

  LatLng? currentPosition;

  Future<void> startListening([void Function(LatLng)? onUpdate]) async{
    await updatePosition(onUpdate);

    listenTimer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      updatePosition(onUpdate);
    });
  }

  Future<void> updatePosition([void Function(LatLng)? onUpdate]) async {
    LatLng? pos = await getCurrent();

    if(onUpdate != null && pos != null){
      onUpdate(pos);
    }
  }

  void stoplistening(){
    listenTimer?.cancel();
  }

  Future<LatLng?> getCurrent() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    Position position = await Geolocator.getCurrentPosition();
    LatLng pos = LatLng(position.latitude, position.longitude);

    currentPosition = pos;

    return pos;
  }
}