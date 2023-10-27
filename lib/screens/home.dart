import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_name/widgets/price_car.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final _panelController = PanelController(); // Use PanelController here

  // A variable to track whether the panel is open or closed.
  bool isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Toggle the panel state when it's tapped.
          if (isPanelOpen) {
            _panelController.close();
          } else {
            _panelController.open();
          }

          // Update the state of the panel.
          setState(() {
            isPanelOpen = !isPanelOpen;
          });
        },
        child: SlidingUpPanel(
          backdropEnabled: true,
          controller: _panelController, // Use PanelController here
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          panel: const PriceCar(),
          onPanelOpened: () async {
            // Handle panel opened event
          },
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) {},
                  zoom: 15,
                  maxZoom: 18,
                  minZoom: 3,
                  center: const LatLng(21.053306461723658, 105.77996412889881),
                ),
                mapController: _animatedMapController.mapController,
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}