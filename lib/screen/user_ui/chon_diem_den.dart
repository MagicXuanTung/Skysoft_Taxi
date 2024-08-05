import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/models/save_marker_model.dart';
import 'package:skysoft_taxi/widgets/destination_header.dart';
import '../../util/api_.dart';
import '../../util/location_service.dart';
import '../../widgets/button/button_save_maker.dart';
import '../../widgets/history_widget.dart';
import 'luu_diem_don.dart';

class ChooseDestination extends StatefulWidget {
  const ChooseDestination({Key? key}) : super(key: key);

  @override
  _ChooseDestinationState createState() => _ChooseDestinationState();
}

class _ChooseDestinationState extends State<ChooseDestination> {
  final TextEditingController _pickupController = TextEditingController();
  final List<TextEditingController> _destinationControllers = [
    TextEditingController()
  ];
  late List<SaveMakerModel> listButtonSaveMaker;
  List<String> _pickupSearchResults = [];
  final Map<TextEditingController, List<String>> _destinationSearchResultsMap =
      {};
  final Map<TextEditingController, bool> _isFirstQueryMap = {};
  bool _isFirstPickupQuery = true;

  @override
  void initState() {
    super.initState();
    _updatePickupLocation();
    _pickupController.addListener(() {
      _searchLocation(_pickupController.text, isPickup: true);
    });
    for (var controller in _destinationControllers) {
      _destinationSearchResultsMap[controller] = [];
      _isFirstQueryMap[controller] = true;
      controller.addListener(() {
        _searchLocation(controller.text,
            isPickup: false, controller: controller);
      });
    }
    listButtonSaveMaker = [
      SaveMakerModel(
        icon: Icons.home,
        text: 'Nhà riêng',
        onTap: () => {
          log('Nhà riêng'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          )
        },
      ),
      SaveMakerModel(
        icon: Icons.work,
        text: 'Công ty',
        onTap: () => {
          log('Công ty'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.restaurant,
        text: 'Nhà hàng',
        onTap: () => {
          log('Nhà hàng'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.coffee,
        text: 'Coffee',
        onTap: () => {
          log('Coffee'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.hotel,
        text: 'Khách sạn',
        onTap: () => {
          log('Khách sạn'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.shopping_cart,
        text: 'Trung tâm thương mại',
        onTap: () => {
          log('Trung tâm thương mại'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.local_atm,
        text: 'ATMs',
        onTap: () => {
          log('ATMs'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.emergency,
        text: 'Bệnh viện',
        onTap: () => {
          log('Bệnh viện'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.medication,
        text: 'Hiệu thuốc',
        onTap: () => {
          log('Hiệu thuốc'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.garage,
        text: 'Nhà để xe',
        onTap: () => {
          log('Nhà để xe'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.local_gas_station,
        text: 'Trạm xăng',
        onTap: () => {
          log('Trạm xăng'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.ev_station,
        text: 'Trạm sạc điện',
        onTap: () => {
          log('Trạm sạc điện'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
      SaveMakerModel(
        icon: Icons.pin_drop,
        text: 'Thêm địa điểm',
        onTap: () => {
          log('Thêm địa điểm'),
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const SaveMakerPlaces();
              },
            ),
          ),
        },
      ),
    ];
  }

  @override
  void dispose() {
    _pickupController.dispose();
    for (var controller in _destinationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _updatePickupLocation() async {
    bool hasPermission = await requestLocationPermission();
    if (hasPermission) {
      try {
        LatLng currentLocation = await getCurrentLocation();
        String locationDetails = await _fetchLocationDetails(
            currentLocation.latitude, currentLocation.longitude);
        _pickupController.text = locationDetails;

        // Fetch and display search results based on the current location
        List<String> suggestions = await _fetchLocationSuggestions(
            currentLocation.latitude, currentLocation.longitude);
        setState(() {
          _pickupSearchResults = suggestions;
        });
      } catch (e) {
        log('Failed to update pickup location: $e');
      }
    } else {
      log('Location permission not granted');
    }
  }

  Future<void> _searchLocation(String query,
      {required bool isPickup, TextEditingController? controller}) async {
    if (query.isNotEmpty) {
      try {
        AutocompleteService apiService = AutocompleteService();
        var suggestions = await apiService.getSuggestions(query);
        setState(() {
          if (isPickup) {
            if (_isFirstPickupQuery) {
              // Skip showing results on the first query for pickup
              _isFirstPickupQuery = false;
            } else {
              _pickupSearchResults = suggestions;
            }
          } else if (controller != null) {
            if (_isFirstQueryMap[controller] == true) {
              // On the first query, do not show results
              _isFirstQueryMap[controller] = false;
              _destinationSearchResultsMap[controller] = [];
            } else {
              _destinationSearchResultsMap[controller] = suggestions;
            }
          }
        });
      } catch (e) {
        log('Error fetching location suggestions: $e');
      }
    } else {
      setState(() {
        if (isPickup) {
          _pickupSearchResults = [];
          _isFirstPickupQuery = true; // Reset flag when query is empty
        } else if (controller != null) {
          _destinationSearchResultsMap[controller] = [];
        }
      });
    }
  }

  Future<List<String>> _fetchLocationSuggestions(
      double latitude, double longitude) async {
    try {
      AutocompleteService apiService = AutocompleteService();
      var suggestions = await apiService.getSuggestions('$latitude,$longitude');
      return suggestions;
    } catch (e) {
      log('Error fetching location suggestions: $e');
      return [];
    }
  }

  Future<String> _fetchLocationDetails(
      double latitude, double longitude) async {
    try {
      AutocompleteService apiService = AutocompleteService();
      var suggestions = await apiService.getSuggestions('$latitude,$longitude');
      return suggestions.isNotEmpty ? suggestions.first : 'No details found';
    } catch (e) {
      log('Error fetching location details: $e');
      return 'Error fetching location details';
    }
  }

  void _addDestinationField() {
    if (_destinationControllers.length < 3) {
      setState(() {
        var controller = TextEditingController();
        _destinationControllers.add(controller);
        _destinationSearchResultsMap[controller] = [];
        _isFirstQueryMap[controller] =
            true; // Initialize as true for first query
        controller.addListener(() {
          _searchLocation(controller.text,
              isPickup: false, controller: controller);
        });
      });
    } else {
      log('Maximum of 3 destination fields reached');
    }
  }

  bool get _isAddDestinationVisible => _destinationControllers.length < 3;

  @override
  Widget build(BuildContext context) {
    final hasPickupSearchResults =
        _pickupSearchResults.isNotEmpty && !_isFirstPickupQuery;
    final hasDestinationSearchResults = _destinationControllers.any(
        (controller) =>
            _destinationSearchResultsMap[controller]?.isNotEmpty ?? false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Chọn điểm đến',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(242, 244, 243, 255),
        child: Column(
          children: [
            DestinationHeader(
              pickupController: _pickupController,
              destinationControllers: _destinationControllers,
              showDragHandle: _destinationControllers.length > 1,
              addDestinationField: _addDestinationField,
              isAddDestinationVisible: _isAddDestinationVisible,
              pickupSearchResults: _pickupSearchResults,
              destinationSearchResultsMap: _destinationSearchResultsMap,
            ),
            if (hasPickupSearchResults) ...[
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: _pickupSearchResults.length,
                  itemBuilder: (context, index) {
                    String result = _pickupSearchResults[index];
                    return ListTile(
                      leading: const Icon(Icons.boy, color: Colors.blue),
                      title: Text(result),
                      trailing:
                          const Icon(Icons.directions, color: Colors.grey),
                      onTap: () {
                        _pickupController.text = result;
                        setState(() {
                          _pickupSearchResults.clear();
                        });
                      },
                    );
                  },
                ),
              ),
            ] else if (hasDestinationSearchResults) ...[
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: _destinationControllers.length,
                  itemBuilder: (context, index) {
                    if (index >= _destinationControllers.length) {
                      return const SizedBox.shrink();
                    }
                    TextEditingController controller =
                        _destinationControllers[index];
                    List<String>? results =
                        _destinationSearchResultsMap[controller];
                    if (results == null || results.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: results.length,
                          itemBuilder: (context, idx) {
                            if (idx >= results.length) {
                              return const SizedBox.shrink();
                            }
                            String result = results[idx];
                            return ListTile(
                              leading: const Icon(Icons.location_on,
                                  color: Colors.redAccent),
                              title: Text(result),
                              trailing: const Icon(Icons.directions,
                                  color: Colors.grey),
                              onTap: () {
                                controller.text = result;
                                setState(() {
                                  _destinationSearchResultsMap[controller]
                                      ?.clear();
                                });
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ] else ...[
              // Show default content when no search results are present
              Column(
                children: [
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Đã lưu',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        'Tất cả',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 50,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listButtonSaveMaker.length,
                      itemBuilder: (context, index) {
                        SaveMakerModel item = listButtonSaveMaker[index];
                        return ButtonSaveMaker(
                          icon: item.icon,
                          text: item.text,
                          onTap: item.onTap,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        'Đã đi',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return HistoryWidget(
                      iconLeft: Icons.location_on,
                      text:
                          'Công ty giám sát hành trình Skysoft, Tầng 2, nhà 21B5 Green Star, Đô Thị Tp. Giao Lưu, P, Q. BắcTừ Liêm, 100000, Việt Nam',
                      onTap: () {
                        // Handle tap on search result
                        log('Selected location: $index+1');
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
