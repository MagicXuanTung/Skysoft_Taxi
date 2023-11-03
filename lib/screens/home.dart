import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/panel_bar.dart';
import '../widgets/side_bar.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);
  final _panelController = PanelController();
  bool isPanelOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: _scaffoldKey, // Add a GlobalKey for the scaffold
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          panel: const PanelBar(),
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
              Positioned(
                top: 40.0,
                left: 15.0,
                child: GestureDetector(
                  onTap: () {
                    // Open the sidebar by showing the drawer
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
