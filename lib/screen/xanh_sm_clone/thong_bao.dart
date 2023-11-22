import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone/info_coupon.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool showCheckbox = false;
  List<bool> checkboxStates = List.filled(10, false);

  List<Coupon> couponList = [
    Coupon(
      id: 0,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
    Coupon(
      id: 2,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
    Coupon(
      id: 3,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
    Coupon(
      id: 4,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
    Coupon(
      id: 5,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
    Coupon(
      id: 6,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
    Coupon(
      id: 7,
      dateTime: DateTime.now(),
      showCheckbox: false,
      onCheckboxChanged: (bool isChecked) {},
    ),
  ];

  void handleRemoveButtonPressed() {
    // Get the indices of checked items
    List<int> checkedIndices = [];
    for (int i = 0; i < checkboxStates.length; i++) {
      if (checkboxStates[i]) {
        checkedIndices.add(i);
      }
    }

    // Remove the checked items from the couponList
    for (int index in checkedIndices) {
      // Ensure the index is within the bounds of the list
      if (index >= 0 && index < couponList.length) {
        couponList.removeAt(index);
      }
    }

    // Clear checkboxStates after removal
    setState(() {
      checkboxStates = List.filled(couponList.length, false);
      showCheckbox = false; // Hide checkboxes after removal
    });
  }

//show or hide the checkboxes in the list
  void toggleCheckboxVisibility() {
    setState(() {
      showCheckbox = !showCheckbox;
    });
  }

//the state of a checkbox changes
  void handleCheckboxChanged(int index, bool isChecked) {
    setState(() {
      checkboxStates[index] = isChecked;
    });
  }

//checks whether at least one checkbox is checked
  bool isAnyCheckboxChecked() {
    return checkboxStates.any((element) => element);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonTopPosition = screenHeight * 0.65;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.red,
            icon: const Icon(Icons.delete_outlined),
            onPressed: () {
              toggleCheckboxVisibility();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(242, 244, 243, 255),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: couponList.length,
              itemBuilder: (context, index) => Coupon(
                id: index, // Pass index as id for simplicity; replace with actual id if available
                dateTime: couponList[index].dateTime,
                showCheckbox: showCheckbox,
                onCheckboxChanged: (isChecked) {
                  handleCheckboxChanged(index, isChecked);
                },
              ),
            ),
          ),
          Positioned(
            top: buttonTopPosition,
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: showCheckbox && isAnyCheckboxChecked(),
              child: Center(
                child: ElevatedButton(
                  onPressed: handleRemoveButtonPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: MediaQuery.of(context).size.width * 0.2,
                    ),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Xóa 1 thông báo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

// ITEMS IN CONTAINER
class Coupon extends StatelessWidget {
  final DateTime dateTime;
  final bool showCheckbox;
  final Function(bool) onCheckboxChanged;
  final int id;

  const Coupon({
    Key? key,
    required this.dateTime,
    required this.showCheckbox,
    required this.onCheckboxChanged,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDateTime = DateFormat('MM/dd/yyyy HH:mm').format(dateTime);

    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const InfoCoupon()),
        ),
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: showCheckbox,
              child: CheckboxExample(
                isChecked: false,
                onCheckboxChanged: onCheckboxChanged,
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.network(
                  'https://image.winudf.com/v2/image1/Y29tLnNreXNvZnQuZ3BzX2ljb25fMTU1OTE4NzY5NF8wMjQ/icon.png?w=184&fakeurl=1',
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDateTime,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Đồng giá 40K Xelo đưa bạn đi ăn trưa!',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green.shade500,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.sell, color: Colors.blue, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Lên kèo đi chơi, lượn lờ phố phường, tận hưởng buổi trưa vui vẻ cùng người thân!',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.group, color: Colors.blueGrey, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Lượt sử dụng 1,8k',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'Đánh giá 5 sao',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CHECK BOX
class CheckboxExample extends StatefulWidget {
  final bool isChecked;
  final Function(bool) onCheckboxChanged;

  const CheckboxExample({
    Key? key,
    required this.isChecked,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = false; // Set the initial value here if needed
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white54;
    }

    return Checkbox(
      checkColor: Colors.blue,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          widget.onCheckboxChanged(isChecked);
        });
      },
    );
  }
}
