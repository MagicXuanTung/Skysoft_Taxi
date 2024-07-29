import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/widgets/input_text.dart';
import '../../util/api_.dart';
import '../../util/location_service.dart';

class QuickFindPlaces extends StatefulWidget {
  const QuickFindPlaces({Key? key}) : super(key: key);

  @override
  State<QuickFindPlaces> createState() => _QuickFindPlacesState();
}

class _QuickFindPlacesState extends State<QuickFindPlaces>
    with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  late final AnimatedMapController _animatedMapController;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  LatLng markerLocation = const LatLng(21.03276589493197, 105.83989509524008);
  final AutocompleteService _autocompleteService = AutocompleteService();
  List<Marker> markers = []; // List to store markers
  final ValueNotifier<double> _markerSizeNotifier = ValueNotifier(20.0);

  @override
  void initState() {
    super.initState();
    _animatedMapController =
        AnimatedMapController(vsync: this, mapController: _mapController);

    handleLocationButtonPress();
  }

  Future<void> handleLocationButtonPress() async {
    bool hasPermission = await requestLocationPermission();
    if (hasPermission) {
      LatLng currentLocation = await getCurrentLocation();
      markerLocation = currentLocation;
      setState(() {});
      _animateToCurrentLocation(currentLocation);

      // Use the current location to query the API and update the text field
      String query = '${currentLocation.latitude},${currentLocation.longitude}';
      try {
        List<String> suggestions =
            await _autocompleteService.getSuggestions(query);
        if (suggestions.isNotEmpty) {
          _pickupController.text =
              suggestions.first; // Update text field with the first suggestion
        }
      } catch (e) {
        // Handle API errors
        if (kDebugMode) {
          print('Error fetching suggestions: $e');
        }
      }
    } else {
      if (kDebugMode) {
        print("Permission not granted");
      }
    }
  }

  void _animateToCurrentLocation(LatLng currentLocation) {
    _animatedMapController.animateTo(
      dest: currentLocation,
      zoom: 18.0,
      rotation: 0.0,
      curve: Curves.easeInOut,
    );
  }

  void _onMapTap(LatLng position) {
    markers.add(
      Marker(
        rotate: true,
        point: position,
        builder: (ctx) => GestureDetector(
          onLongPress: () => _removeMarker(position),
          child: Icon(
            Icons.location_on,
            color: Colors.redAccent,
            size: _markerSizeNotifier.value,
          ),
        ),
      ),
    );
    setState(() {});
  }

  void _removeMarker(LatLng position) {
    setState(() {
      markers.removeWhere((marker) => marker.point == position);
    });
  }

  void _clearAllMarkers() {
    setState(() {
      markers.clear(); // Clear all markers
    });
  }

  double calculateMarkerSize(double zoom) {
    if (zoom <= 10) {
      return 20.0;
    } else if (zoom <= 15) {
      return 30.0;
    } else {
      return 40.0;
    }
  }

  void _updateMarkerSize(double? zoom) {
    // Use a default zoom value if zoom is null
    double currentZoom = zoom ?? 13.0; // Default to 13.0 if zoom is null

    double newSize = calculateMarkerSize(currentZoom);

    // Update marker size using a ValueNotifier or any state management
    _markerSizeNotifier.value =
        newSize.clamp(20.0, 40.0); // Ensure size is within the range
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Chọn điểm đến',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              zoom: 13.0,
              minZoom: 5.0,
              maxZoom: 18.0,
              onPositionChanged: (position, hasGesture) {
                _updateMarkerSize(position.zoom);
              },
              onTap: (position, latLng) {
                _onMapTap(latLng); // Add marker on tap
              },
            ),
            mapController: _animatedMapController.mapController,
            children: [
              TileLayer(
                backgroundColor: Colors.transparent,
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              CurrentLocationLayer(),
              ValueListenableBuilder<double>(
                valueListenable: _markerSizeNotifier,
                builder: (context, markerSize, child) {
                  return MarkerLayer(
                    markers: markers.map((marker) {
                      return Marker(
                        rotate: true,
                        point: marker.point,
                        builder: (ctx) {
                          return GestureDetector(
                            onLongPress: () => _removeMarker(marker.point),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: markerSize,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
          InputText(
            pickupController: _pickupController,
            destinationController: _destinationController,
            onBack: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ElevatedButton(
            onPressed: () {
              log('Xác nhận điểm');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.3,
              ),
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text(
              'Xác nhận điểm',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: UniqueKey(),
              onPressed: () {
                _clearAllMarkers();
              },
              child: const Icon(
                color: Colors.black,
                Icons.wrong_location,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 45,
            width: 45,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: UniqueKey(),
              onPressed: () {
                handleLocationButtonPress();
              },
              child: const Icon(
                color: Colors.black,
                Icons.my_location,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
