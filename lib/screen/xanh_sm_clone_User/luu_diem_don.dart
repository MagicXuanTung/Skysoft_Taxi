import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SaveMakerPlaces extends StatefulWidget {
  const SaveMakerPlaces({Key? key}) : super(key: key);

  @override
  State<SaveMakerPlaces> createState() => _SaveMakerPlacesState();
}

class _SaveMakerPlacesState extends State<SaveMakerPlaces>
    with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  late AnimationController _animationController;
  late Animation<double> _movementAnimation;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  LatLng markerLocation = const LatLng(21.03276589493197, 105.83989509524008);

  @override
  void initState() {
    // handleLocationButtonPress();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _movementAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_animationController);
  }

  void handleLocationButtonPress() {
    requestLocationPermission().then(
      (bool hasPermission) {
        if (hasPermission) {
          getCurrentLocation().then(
            (LatLng currentLocation) {
              markerLocation = currentLocation;
              setState(() {});
              _animateToCurrentLocation(currentLocation);
            },
          );
        } else {
          if (kDebugMode) {
            print("Permission not granted");
          }
        }
      },
    );
  }

  void _animateToCurrentLocation(LatLng currentLocation) {
    final startingCenter = _mapController.center;
    _animationController.forward(from: 0);
    _movementAnimation.addListener(
      () {
        final newCenter = LatLng(
          lerpDouble(startingCenter.latitude, currentLocation.latitude,
              _movementAnimation.value)!,
          lerpDouble(startingCenter.longitude, currentLocation.longitude,
              _movementAnimation.value)!,
        );
        _mapController.move(newCenter, _mapController.zoom * 2);
      },
    );
  }

  Future<bool> requestLocationPermission() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<LatLng> getCurrentLocation() async {
    LocationData locationData = await Location().getLocation();
    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Thêm địa điểm để lưu',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              maxZoom: 18,
              minZoom: 3,
            ),
            mapController: _mapController,
            nonRotatedChildren: const [
              Center(
                child: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              CurrentLocationLayer(),
            ],
          ),
          InputText(
            pickupController: _pickupController,
            destinationController: _destinationController,
            onBack: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.65,
            left: MediaQuery.of(context).size.width * 0.85,
            right: 0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                handleLocationButtonPress();
              },
              mini: true,
              child: const Icon(
                color: Colors.black,
                Icons.my_location,
                size: 20,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: 0,
            right: 0,
            child: Center(
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
        ],
      ),
    );
  }
}

class InputText extends StatefulWidget {
  final TextEditingController pickupController;
  final TextEditingController destinationController;
  final void Function() onBack;

  const InputText({
    Key? key,
    required this.pickupController,
    required this.destinationController,
    required this.onBack,
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey.shade200,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTextField(
                      controller: widget.pickupController,
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      hintText: 'Điểm đánh dấu ...',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required Icon prefixIcon,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      onChanged: (text) {
        setState(() {});
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        border: InputBorder.none,
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                  setState(() {});
                },
                child: const Icon(Icons.clear),
              )
            : null,
      ),
    );
  }
}
