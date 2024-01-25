import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/LocationController.dart';
import 'package:pokegrunn/models/CarouselItem.dart';

class AchievementModel with CarouselItem {
  String? name;
  int? points;
  String? description;
  String? category;
  double? latitude;
  double? longitude;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? image;

  @override
  String? get desc => description;

  @override
  String? get title => name;

  @override
  String? get icon => image;

  LatLng? get position {
    return latitude != null && longitude != null ? LatLng(latitude!, longitude!) : null;
  }

  AchievementModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    description = json["description"];
    points = json["points"];
    category = json["category"];
    latitude = double.parse(json["latitude"]);
    longitude = double.parse(json["longitude"]);
    startDate = json["start_date"];
    endDate = json["end_date"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    image = json["image_url"];
  }
  
  @override
  int get id => throw UnimplementedError();
}