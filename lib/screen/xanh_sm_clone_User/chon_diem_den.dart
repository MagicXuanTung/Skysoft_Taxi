import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/models/save_marker.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/luu_diem_don.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/tim_diem_den%20_nhanh.dart';
import 'package:skysoft_taxi/widgets/button/button_save_maker.dart';
import 'package:skysoft_taxi/widgets/destination_header.dart';
import 'package:skysoft_taxi/widgets/history_widget.dart';

import '../../util/connectivity_handler.dart';

class ChooseDestination extends StatefulWidget {
  const ChooseDestination({Key? key}) : super(key: key);

  @override
  _ChooseDestinationState createState() => _ChooseDestinationState();
}

class _ChooseDestinationState extends State<ChooseDestination> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  late List<SaveMaker> listButtonSaveMaker;
  late ConnectivityHandler _connectivityHandler;

  @override
  void initState() {
    _connectivityHandler = ConnectivityHandler();
    _connectivityHandler.startListening(context);
    super.initState();
    listButtonSaveMaker = [
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
      SaveMaker(
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
    _connectivityHandler.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(242, 244, 243, 255),
        child: Column(
          children: <Widget>[
            DestinationHeader(
              pickupController: _pickupController,
              destinationController: _destinationController,
              onBack: () {
                Navigator.of(context).pop();
              },
              navigateToQuickFindPlaces: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const QuickFindPlaces();
                    },
                  ),
                );
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
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
                        SaveMaker item = listButtonSaveMaker[index];
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      HistoryWidget(
                        iconLeft: Icons.history,
                        text:
                            'Tầng 2, 21B5 GreenStars, Khu ĐT Tp Giao Lưu, P. Cổ Nhuế 1, Q. Bắc Từ Liêm, Hà Nội',
                        onTap: () {
                          log('Hạng thành viên');
                        },
                      ),
                    ],
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
