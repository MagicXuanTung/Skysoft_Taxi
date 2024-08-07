import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/models/save_marker_model.dart';
import 'package:skysoft_taxi/screen/user_ui/luu_diem_don.dart';
import 'package:skysoft_taxi/widgets/destination_header.dart';
import '../../util/location_service.dart';
import '../../widgets/button/button_save_maker.dart';
import '../../widgets/history_widget.dart';

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
  List<SaveMakerModel> listButtonSaveMaker = [];
  List<String> pickupString = [];
  List<String> destinationString = [];
  bool isPickupSearch = false;
  bool isSearching = false;
  int currentDestinationIndex = 0;

  @override
  void initState() {
    super.initState();
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

  void _addDestinationField() {
    if (_destinationControllers.length < 3) {
      setState(() {
        _destinationControllers.add(TextEditingController());
      });
    } else {
      log('Maximum of 3 destination fields reached');
    }
  }

  void _handleSearch(String query,
      {bool isPickup = false, int destinationIndex = 0}) async {
    setState(() {
      isSearching = query.isNotEmpty;
      isPickupSearch = isPickup;
      currentDestinationIndex = destinationIndex;
    });

    if (isSearching) {
      List<String> list = await searchLocation(query);
      setState(() {
        if (isPickupSearch) {
          pickupString = list;
        } else {
          destinationString = list;
        }
      });
    } else {
      setState(() {
        pickupString.clear();
        destinationString.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSearchResults =
        pickupString.isNotEmpty || destinationString.isNotEmpty;

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
              pickUpSearch: (nameLoc) {
                _handleSearch(nameLoc, isPickup: true);
              },
              destinationSearch: (nameLoc, int index) {
                _handleSearch(nameLoc,
                    isPickup: false, destinationIndex: index);
              },
            ),
            if (isSearching && hasSearchResults) ...[
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: isPickupSearch
                      ? pickupString.length
                      : destinationString.length,
                  itemBuilder: (context, index) {
                    String result = isPickupSearch
                        ? pickupString[index]
                        : destinationString[index];
                    return ListTile(
                      leading: Icon(
                        isPickupSearch ? Icons.boy : Icons.location_on,
                        color: isPickupSearch ? Colors.blue : Colors.redAccent,
                      ),
                      title: Text(result),
                      trailing:
                          const Icon(Icons.directions, color: Colors.grey),
                      onTap: () {
                        log('Selected: $result'); // Debugging log
                        setState(() {
                          if (isPickupSearch) {
                            _pickupController.text = result;
                            pickupString.clear(); // Clear search results
                          } else {
                            if (_destinationControllers.isNotEmpty) {
                              _destinationControllers[currentDestinationIndex]
                                  .text = result;
                              destinationString.clear(); // Clear search results
                            }
                          }
                          isSearching = false; // Hide the list after selection
                        });
                      },
                    );
                  },
                ),
              ),
            ] else ...[
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
