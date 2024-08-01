import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/models/save_marker_model.dart';
import 'package:skysoft_taxi/widgets/button/button_save_maker.dart';
import 'package:skysoft_taxi/widgets/destination_header.dart';
import '../../util/api_.dart';
import '../../util/location_service.dart';
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
  List<String> _searchResults = []; // To store search results

  @override
  void initState() {
    super.initState();
    _updatePickupLocation();
    _pickupController.addListener(() {
      _searchLocation(_pickupController.text, isPickup: true);
    });
    _destinationControllers.forEach((controller) {
      controller.addListener(() {
        _searchLocation(controller.text, isPickup: false);
      });
    });

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
          _searchResults = suggestions;
        });
      } catch (e) {
        log('Failed to update pickup location: $e');
      }
    } else {
      log('Location permission not granted');
    }
  }

  Future<void> _searchLocation(String query, {required bool isPickup}) async {
    if (query.isNotEmpty) {
      try {
        // Modify this if your API service has different methods
        AutocompleteService apiService = AutocompleteService();
        var suggestions = await apiService.getSuggestions(query);
        setState(() {
          _searchResults = suggestions;
        });
      } catch (e) {
        log('Error fetching location suggestions: $e');
      }
    } else {
      setState(() {
        _searchResults = [];
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
      // Fetch details for displaying in _pickupController
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
        _destinationControllers.add(TextEditingController());
      });
    } else {
      // You can show a message or handle the limit reached scenario here
      log('Maximum of 3 destination fields reached');
    }
  }

  bool get _isAddDestinationVisible =>
      _destinationControllers.length <
      3; // Kiểm tra số lượng destination fields
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: <Widget>[
            DestinationHeader(
              pickupController: _pickupController,
              destinationControllers: _destinationControllers,
              showDragHandle: _destinationControllers.length > 1,
              addDestinationField: _addDestinationField,
              isAddDestinationVisible:
                  _isAddDestinationVisible, // Truyền giá trị vào DestinationHeader
            ),
            SingleChildScrollView(
              child: Column(
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
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  String result = _searchResults[index];
                  return ListTile(
                    title: Text(result),
                    onTap: () {
                      // Handle tap on search result
                      log('Selected location: $result');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
