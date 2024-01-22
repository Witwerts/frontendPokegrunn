import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokegrunn/controllers/LocationController.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
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


  MapPageState(){
    mapController = LocationController(animationManager);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            center: LatLng(53.241440630171795, 6.5332570758746265),
            zoom: 14,
            interactiveFlags: InteractiveFlag.all,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(
              followOnLocationUpdate: followMe ? FollowOnLocationUpdate.always : FollowOnLocationUpdate.never,
              turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(),
                markerDirection: MarkerDirection.top,
              ),
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