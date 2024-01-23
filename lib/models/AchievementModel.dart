import 'package:flutter/material.dart';
import 'package:pokegrunn/models/CarouselItem.dart';

class AchievementModel with CarouselItem {
  String? name;
  int? points;
  String? description;
  String? category;
  String? latitude;
  String? longitude;
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

  AchievementModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    points = json["points"];
    category = json["category"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    startDate = json["start_date"];
    endDate = json["end_date"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    image = json["image_url"];
  }
  
  @override
  int get id => throw UnimplementedError();
}