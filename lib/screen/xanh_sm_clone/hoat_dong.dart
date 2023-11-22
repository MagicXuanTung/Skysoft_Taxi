import 'package:flutter/material.dart';

class ActivityDaily extends StatefulWidget {
  const ActivityDaily({Key? key}) : super(key: key);

  @override
  State<ActivityDaily> createState() => _ActivityDailyState();
}

class _ActivityDailyState extends State<ActivityDaily> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(242, 244, 243, 255),
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight / 5,
                  child: Image.network(
                    'https://img.freepik.com/premium-vector/taxi-online-service-mobile-application-with-yellow-taxicab-location-map-get-taxi-concept-order-taxi-service-3d-perspective-vector-illustration_473922-237.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        SizedBox(
                          height: screenHeight / 12,
                          child: ClipOval(
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfywSMGV0KkBIMFVH4PkRlH63yLFhXjL56tQ&usqp=CAU',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Bạn đã trải nghiệm\nxe Xelo chưa?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Hơn 1 triệu chuyến đi đã được tài xế Xelo phục vụ chỉ \n trong 10 tuần đầu tiên.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Đặt xe ngay',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
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
