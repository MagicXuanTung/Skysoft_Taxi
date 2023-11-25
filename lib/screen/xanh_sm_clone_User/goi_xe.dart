import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/screen/home.dart';

class BookingCar extends StatefulWidget {
  const BookingCar({Key? key}) : super(key: key);

  @override
  State<BookingCar> createState() => _BookingCarState();
}

class _BookingCarState extends State<BookingCar> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: const Color.fromARGB(242, 244, 243, 255),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: screenHeight / 4,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            'https://www.taxionthego.com/wp-content/uploads/2019/12/banner_1-min.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Xin chào ${userModel.name}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.waving_hand,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 50,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 90,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ButtonImage(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/1801/1801444.png',
                          text: 'Ô tô',
                          onTap: () {
                            log('Ô tô');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://cdn2.iconfinder.com/data/icons/transportation-colorized/64/transportation-vehicle-11-512.png',
                          text: 'Xe máy',
                          onTap: () {
                            log('Xe máy');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://icon-library.com/images/on-time-icon/on-time-icon-13.jpg',
                          text: 'Thuê xe theo giờ',
                          onTap: () {
                            log('Thuê Xe');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://www.airasia.com/aa/ride/images/icon-car.png',
                          text: 'Sân bay',
                          onTap: () {
                            log('Sân bay');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/4234/4234147.png',
                          text: 'Đặt xe cho bạn bè',
                          onTap: () {
                            log('Đặt xe cho bạn bè');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/6947/6947616.png',
                          text: 'Giao Hàng',
                          onTap: () {
                            log('Giao Hàng');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/776/776443.png',
                          text: 'Đồ ăn',
                          onTap: () {
                            log('Đồ ăn');
                          },
                        ),
                        ButtonImage(
                          imagePath:
                              'https://cdn-icons-png.flaticon.com/512/5952/5952766.png',
                          text: 'Giao Hàng Ô tô',
                          onTap: () {
                            log('Giao Hàng Ô tô');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const HorizontalImageSlider(
                    imageUrls: [
                      'https://www.ganeshawebtech.com/wp-content/uploads/2018/06/Get-your-taxi-business-an-edge-by-getting-a-Taxi-booking-apps.jpg',
                      'https://i.ytimg.com/vi/PN3YyMcHuhc/maxresdefault.jpg',
                      'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/263260978/original/01063a5489f4f3bccd2ae5db726c2f156dfbc6e0/taxi-booking-app-car-booking-app-taxi-app-uber-clone-app-car-rental-app.jpg',
                      'https://cdn.grabon.in/gograbon/images/merchant/1624792553223.jpg',
                      'https://couponswala.com/blog/wp-content/uploads/2021/08/goibibo-cab-coupons.jpg',
                      'https://www.icoderzsolutions.com/blog/wp-content/uploads/2021/03/5-Steps-In-Hiring-The-Best-Taxi-App-Development-Company.png',
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.05 * MediaQuery.of(context).size.width,
                  vertical: 0.22 * MediaQuery.of(context).size.height,
                ),
                child: GestureDetector(
                  onTap: () {
                    log("Bạn muốn đi đâu ?");
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0.1,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 0.2,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.flag,
                              color: Color.fromARGB(255, 255, 64, 64)),
                          const SizedBox(width: 10),
                          const Text(
                            'Bạn muốn đi đâu ?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              log("bản đồ");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Home()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              elevation: 0,
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 13,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'Bản Đồ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaveMaker extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const SaveMaker({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 12,
              color: Colors.blue,
            ),
            const SizedBox(width: 5.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonImage extends StatelessWidget {
  final String imagePath; // Path to the image asset
  final String text;

  final VoidCallback? onTap;

  const ButtonImage(
      {Key? key, required this.imagePath, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  imagePath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class HorizontalImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const HorizontalImageSlider({super.key, required this.imageUrls});

  @override
  // ignore: library_private_types_in_public_api
  _HorizontalImageSliderState createState() => _HorizontalImageSliderState();
}

class _HorizontalImageSliderState extends State<HorizontalImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (_currentPage < widget.imageUrls.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrls[index],
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}