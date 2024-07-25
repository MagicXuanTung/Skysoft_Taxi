import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/models/banner_image_model.dart';
import 'package:skysoft_taxi/models/circular_image_widget_model.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/chon_diem_den.dart';
import 'package:skysoft_taxi/widgets/imageWidget/circular_image_widget.dart';
import 'package:skysoft_taxi/widgets/tab_widget.dart';

class ActivityDaily extends TabWidget {
  const ActivityDaily({Key? key})
      : super(icon: const Icon(Icons.schedule), title: "Hoạt Động", key: key);

  @override
  _ActivityDailyState createState() => _ActivityDailyState();
}

class _ActivityDailyState extends State<ActivityDaily> {
  late PageController _pageController;
  bool _isLeftActive = true;
  int _selectedButtonIndex = 0;

  BannerImageModel bannerImageModel = BannerImageModel(
    imageUrl: "https://skysoft.vn/userfiles/389/giai+phap+quan+ly+xe+tai.jpg",
  );
  CircularImageModel circularImageModel = CircularImageModel(
    imageUrl:
        "https://image.winudf.com/v2/image1/Y29tLnNreXNvZnQuZ3BzX2ljb25fMTU1OTE4NzY5NF8wMjQ/icon.png?w=184&fakeurl=1",
  );
  CircularImageModel circularImageModel_1 = CircularImageModel(
    imageUrl:
        "https://www.freepnglogos.com/uploads/taxi-png/taxi-png-images-are-download-crazypngm-31.png",
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleTab(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _isLeftActive = index == 0;
    });
  }

  void _selectButton(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Hoạt Động',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(35.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.82,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _toggleTab(0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _isLeftActive
                              ? Colors.deepOrangeAccent
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              color:
                                  _isLeftActive ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Đang trong chuyến',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    _isLeftActive ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () => _toggleTab(1),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: !_isLeftActive
                              ? Colors.deepOrangeAccent
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              color:
                                  !_isLeftActive ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Lịch sử',
                              style: TextStyle(
                                fontSize: 12,
                                color: !_isLeftActive
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _isLeftActive = index == 0;
          });
        },
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Image.network(
                bannerImageModel.imageUrl,
                fit: BoxFit.cover,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CircularImageWidget(
                          imageUrl: circularImageModel.imageUrl),
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
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const ChooseDestination();
                              },
                            ),
                          );
                          log('Đặt xe ngay');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: MediaQuery.of(context).size.width * 0.1,
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
          Column(
            children: [
              SizedBox(
                height: 35.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ElevatedButton(
                        onPressed: () => _selectButton(0),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedButtonIndex == 0
                              ? Colors.blueAccent
                              : Colors.white70,
                          minimumSize: const Size(50, 15), // Adjusted size
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10), // Adjust padding
                        ),
                        child: Text(
                          'Đi lại',
                          style: TextStyle(
                            color: _selectedButtonIndex == 0
                                ? Colors.white
                                : Colors.black,
                            fontSize: 12, // Adjusted font size if necessary
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ElevatedButton(
                        onPressed: () => _selectButton(1),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedButtonIndex == 1
                              ? Colors.blueAccent
                              : Colors.white70,
                          minimumSize: const Size(50, 15), // Adjusted size
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10), // Adjust padding
                        ),
                        child: Text(
                          'Giao hàng',
                          style: TextStyle(
                            color: _selectedButtonIndex == 1
                                ? Colors.white
                                : Colors.black,
                            fontSize: 12, // Adjusted font size if necessary
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ElevatedButton(
                        onPressed: () => _selectButton(2),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedButtonIndex == 2
                              ? Colors.blueAccent
                              : Colors.white70,
                          minimumSize: const Size(50, 10), // Adjusted size
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10), // Adjust padding
                        ),
                        child: Text(
                          'Thuê xe',
                          style: TextStyle(
                            color: _selectedButtonIndex == 2
                                ? Colors.white
                                : Colors.black,
                            fontSize: 12, // Adjusted font size if necessary
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    CircularImageWidget(
                        imageUrl: circularImageModel_1.imageUrl),
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const ChooseDestination();
                            },
                          ),
                        );
                        log('Đặt xe ngay');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.width * 0.1,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
