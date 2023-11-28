import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/models/save_marker.dart';
import 'package:skysoft_taxi/widgets/button/button_save_maker.dart';

class ChooseDestination extends StatefulWidget {
  const ChooseDestination({Key? key}) : super(key: key);

  @override
  _ChooseDestinationState createState() => _ChooseDestinationState();
}

class _ChooseDestinationState extends State<ChooseDestination> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  List<SaveMaker> listButtonSaveMaker = [
    SaveMaker(
      icon: Icons.home,
      text: 'Nhà riêng',
      onTap: () => {
        log('Nhà riêng'),
      },
    ),
    SaveMaker(
      icon: Icons.work,
      text: 'Công ty',
      onTap: () => {
        log('Công ty'),
      },
    ),
    SaveMaker(
      icon: Icons.restaurant,
      text: 'Nhà hàng',
      onTap: () => {
        log('Nhà hàng'),
      },
    ),
    SaveMaker(
      icon: Icons.coffee,
      text: 'Coffee',
      onTap: () => {
        log('Coffee'),
      },
    ),
    SaveMaker(
      icon: Icons.hotel,
      text: 'Khách sạn',
      onTap: () => {
        log('Khách sạn'),
      },
    ),
    SaveMaker(
      icon: Icons.shopping_cart,
      text: 'Trung tâm thương mại',
      onTap: () => {
        log('Trung tâm thương mại'),
      },
    ),
    SaveMaker(
      icon: Icons.local_atm,
      text: 'ATMs',
      onTap: () => {
        log('ATMs'),
      },
    ),
    SaveMaker(
      icon: Icons.emergency,
      text: 'Bệnh viện',
      onTap: () => {
        log('Bệnh viện'),
      },
    ),
    SaveMaker(
      icon: Icons.medication,
      text: 'Hiệu thuốc',
      onTap: () => {
        log('Hiệu thuốc'),
      },
    ),
    SaveMaker(
      icon: Icons.garage,
      text: 'Nhà để xe',
      onTap: () => {
        log('Nhà để xe'),
      },
    ),
    SaveMaker(
      icon: Icons.local_gas_station,
      text: 'Trạm xăng',
      onTap: () => {
        log('Trạm xăng'),
      },
    ),
    SaveMaker(
      icon: Icons.ev_station,
      text: 'Trạm sạc điện',
      onTap: () => {
        log('Trạm sạc điện'),
      },
    ),
    SaveMaker(
      icon: Icons.pin_drop,
      text: 'Thêm địa điểm',
      onTap: () => {
        log('Thêm địa điểm'),
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(242, 244, 243, 255),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Chọn điểm đến ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
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
              child: Column(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          buildTextField(
                            controller: _pickupController,
                            prefixIcon: const Icon(
                              Icons.boy,
                              color: Colors.blue,
                            ),
                            hintText: 'Nhập điểm đón ...',
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.blue,
                            indent: 20,
                            endIndent: 20,
                          ),
                          buildTextField(
                            controller: _destinationController,
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Colors.orangeAccent,
                            ),
                            hintText: 'Nhập điểm đến ...',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildIconContainer(
                            icon: const Icon(Icons.map),
                            text: 'Chọn điểm đến',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
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
              height: 55,
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.grey[200],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      leading: const Icon(Icons.history),
                      title: Text('Lịch sử chuyến đi $index'),
                      subtitle: Text('Di chuyển tới điểm $index'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        print('lịch sử $index');
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
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
        setState(() {}); // Trigger a rebuild to show/hide the delete button
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        border: InputBorder.none,
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                  setState(
                      () {}); // Trigger a rebuild to hide the delete button
                },
                child: const Icon(Icons.clear),
              )
            : null,
      ),
    );
  }
}

Widget buildIconContainer({required Icon icon, required String text}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon.icon,
          color: Colors.black,
          size: 20,
        ),
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    ],
  );
}

class ChooseOnMapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        print('choose on map');
      },
      icon: const Icon(Icons.location_searching),
      label: const Text('Choose on Map'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        print('start');
        Navigator.pop(context, 'startButtonPressed');
      },
      icon: const Icon(Icons.near_me),
      label: const Text('Test di chuyển'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey),
      ),
    );
  }
}
