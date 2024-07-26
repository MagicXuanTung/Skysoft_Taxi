import 'package:flutter/material.dart';

class DestinationInformation extends StatefulWidget {
  const DestinationInformation({super.key});

  @override
  _DestinationInformationState createState() => _DestinationInformationState();
}

class _DestinationInformationState extends State<DestinationInformation> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
            child: Icon(
              Icons.horizontal_rule,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              controller: controller,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(bottom: 5, left: 5),
                  child: Text(
                    'Hà Nội',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, top: 16),
                  child: Text('Thời gian: 150 phút',
                      style: TextStyle(fontSize: 18)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, top: 10, bottom: 16),
                  child: Text('Quãng đường: 117 km',
                      style: TextStyle(fontSize: 18)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print('instruction');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.directions, size: 24),
                            Text(' Đường đi'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print('start');
                          // widget.bookCar();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.assistant_navigation, size: 24),
                            Text(' Đặt xe'),
                          ],
                        ),
                      ),
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
