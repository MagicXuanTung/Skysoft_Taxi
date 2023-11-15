import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchOnPanalBar extends StatelessWidget {
  const SearchOnPanalBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SlidingUpPanel(
      minHeight: screenHeight,
      maxHeight: screenHeight,
      panel: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Material(
                color: Colors.transparent, // Đặt màu nền là trong suốt
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const IconButton(
                    icon: Icon(Icons.close),
                    onPressed: null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.near_me),
                      hintText: 'Current Location',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      hintText: 'Enter your destination',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 10.0),
                  Container(
                    width: 200,
                    child: StartButton(),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    width: 200,
                    child: ChooseOnMapButton(),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    width: 200,
                    child: StartButton(),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    width: 200,
                    child: ChooseOnMapButton(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
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
