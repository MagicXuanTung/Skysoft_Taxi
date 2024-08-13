import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/widgets/input_text.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../util/api_.dart';
import '../../util/location_service.dart';
import '../../widgets/user/paymentMethod.dart';
import '../../widgets/user/price_car.dart';
import '../../widgets/user/ride_requested.dart';

class MapUser extends StatefulWidget {
  const MapUser({Key? key}) : super(key: key);

  @override
  State<MapUser> createState() => _MapUserState();
}

class _MapUserState extends State<MapUser> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  late final AnimatedMapController _animatedMapController;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  LatLng markerLocation = const LatLng(21.03276589493197, 105.83989509524008);
  final AutocompleteService _autocompleteService = AutocompleteService();
  List<Marker> markers = []; // List to store markers
  final ValueNotifier<double> _markerSizeNotifier = ValueNotifier(20.0);
  String selectedText = "Regular";
  IconData paymentMethod = Icons.payments;
  String paymentName = "Phương thức thanh toán";
  bool rideRequested = false;
  final PanelController _panelController = PanelController();
  final ValueNotifier<double> _floatingButtonYOffset =
      ValueNotifier(0.0); // Notifier for floating button offset

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

  void choosePayment(IconData icon, String name) {
    paymentMethod = icon;
    paymentName = name;
    setState(() {});
  }

  void _togglePanel() {
    if (_panelController.isPanelOpen) {
      _panelController.close();
    } else {
      _panelController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
                urlTemplate: "http://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.075,
            left: MediaQuery.of(context).size.width * 0.02,
            child: FloatingActionButton(
              mini: true, // Giữ cho nút ở kích thước tiêu chuẩn
              backgroundColor: Colors.white,
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              shape: const CircleBorder(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ), // Đảm bảo nút có hình dạng tròn
            ),
          ),
          InputText(
            pickupController: _pickupController,
            destinationController: _destinationController,
            onBack: () {
              Navigator.of(context).pop();
            },
          ),
          SlidingUpPanel(
            controller: _panelController,
            minHeight: rideRequested ? 250 : 140,
            maxHeight: rideRequested ? 250 : 500,
            panel: rideRequested
                ? const RideRequested()
                : PriceCar(
                    panelController: _panelController,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: rideRequested
          ? null
          : Container(
              height: 115,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        log("Phương thức thanh toán");
                        selectedText = "Phương thức thanh toán";
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                log("Phương thức thanh toán");
                                setState(() {
                                  selectedText = "Phương thức thanh toán";
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                        onDone: (method, name) =>
                                            choosePayment(method, name)),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 20),
                                      Icon(
                                        paymentMethod,
                                        color: selectedText ==
                                                "Phương thức thanh toán"
                                            ? Colors.blue
                                            : Colors.blueGrey,
                                        size: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                          5,
                                          5,
                                          10,
                                          1,
                                        ),
                                        child: Text(
                                          paymentName,
                                          style: TextStyle(
                                            color: selectedText ==
                                                    "Phương thức thanh toán"
                                                ? Colors.blue
                                                : Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                log("Ưu đãi");
                                selectedText = "Ưu đãi";
                                setState(() {});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    color: selectedText == "Ưu đãi"
                                        ? Colors.blue
                                        : Colors.blueGrey,
                                    size: 16,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                      5,
                                      5,
                                      30,
                                      1,
                                    ),
                                    child: Text(
                                      'Ưu đãi',
                                      style: TextStyle(
                                        color: selectedText == "Ưu đãi"
                                            ? Colors.blue
                                            : Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: SizedBox(
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      rideRequested =
                                          true; // Cập nhật trạng thái khi người dùng nhấn "Đặt xe"
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amberAccent,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 11, 20, 11),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    textAlign: TextAlign.center,
                                    'Đặt xe',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  log('Đặt lịch');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE2E4E9),
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 11, 20, 11),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.calendar_month,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: FloatingActionButton(
              shape: const CircleBorder(),
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
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              heroTag: UniqueKey(),
              onPressed: () {
                handleLocationButtonPress();
                _panelController.close();
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
