import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool showCheckbox = false;

  void toggleCheckboxVisibility() {
    setState(() {
      showCheckbox = !showCheckbox;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: const Color.fromARGB(242, 244, 243, 255),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => ContainerItem(
            dateTime: DateTime.now(),
            showCheckbox: showCheckbox,
          ),
        ),
      ),
    );
  }
}

class ContainerItem extends StatelessWidget {
  final DateTime dateTime;
  final bool showCheckbox;

  const ContainerItem(
      {Key? key, required this.dateTime, required this.showCheckbox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDateTime = DateFormat('MM/dd/yyyy HH:mm').format(dateTime);

    return Container(
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
            child: const CheckboxExample(),
          ),
          SizedBox(
            width: 40, // Adjust the width as needed
            height: 40, // Adjust the height as needed
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
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

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
        });
      },
    );
  }
}
