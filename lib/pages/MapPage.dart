import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/LocationController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/widgets/Mapitem.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class MapPage extends NavigationPage  {
  const MapPage({super.key});

  @override
  String get routePath => "/map";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => MapPageState();
}

class MapPageState extends NavigationPageState {
  late LocationController mapController;
  bool followMe = false;
  List<Marker> markerList = [];


  MapPageState(){
    mapController = LocationController(animationManager);
  }

  void createMarkers(AchievementController achievementController) {
    List<Marker> markers = [];

    for (AchievementModel achievement in achievementController.achievements) {
      double lon = double.parse(achievement.longitude!);
      double lat = double.parse(achievement.latitude!);

      markers.add(
        Marker(
          point: LatLng(lat, lon),
          width: 60.0,
          height: 60.0,
          alignment: Alignment.topCenter,
          child: MapItem(achievement: achievement),
        )
      );
    }

    setState(() {
      markerList = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController = Provider.of<AchievementController>(context);
    createMarkers(achievementController);

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            initialCenter: LatLng(53.241440630171795, 6.5332570758746265),
            initialZoom: 14,
            interactionOptions: InteractionOptions(),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(
              alignPositionOnUpdate: followMe ? AlignOnUpdate.always : AlignOnUpdate.never,
              alignDirectionOnUpdate: AlignOnUpdate.never,
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(),
                markerDirection: MarkerDirection.top,
              ),
            ),
            MarkerLayer(
              markers: markerList
            )
          ],
        ),
        const Titlebar(title: "Achievements in de buurt"),
      ],
    );

    /*return Scaffold(
      backgroundColor: MainApp.color1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Achievements in de buurt",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );*/
  }
}