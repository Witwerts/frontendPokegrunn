import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/LocationController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
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
  List<Marker> markerList = [];


  MapPageState(){
    mapController = LocationController(animationManager);
  }

  void createMarkers(AchievementController achievementController) {
    List<Marker> markers = [];

    for (AchievementModel achievement in achievementController.achievements) {
      double lon = achievement.longitude!;
      double lat = achievement.latitude!;

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
    AccountController accountController  = Provider.of<AccountController>(context);
    createMarkers(achievementController);

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            initialCenter: LatLng(53.2177454, 6.5615083), //groningen!
            initialZoom: 12,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.all
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(
              alignPositionOnUpdate: AlignOnUpdate.never,
              alignDirectionOnUpdate: AlignOnUpdate.never,
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(),
                markerDirection: MarkerDirection.top,
              ),
            ),
            MarkerLayer(
              markers: markerList,
              rotate: true,
            )
          ],
        ),
        const Titlebar(title: "Achievements in de buurt"),
        Positioned(
          top: 90,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                ),
                margin: const EdgeInsets.all(8.0),
                child: Center (
                  child: IconButton.outlined(
                    iconSize: 32,
                    color: MainApp.color3,
                    padding: const EdgeInsets.all(6.0),
                    onPressed: (() async {
                      await mapController.FlyTo(accountController.position!, 16);
                    }),
                    icon: Icon(
                      Icons.my_location,
                      size: 32,
                      color: MainApp.color3.withOpacity(0.8)
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black.withOpacity(0.2))
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}