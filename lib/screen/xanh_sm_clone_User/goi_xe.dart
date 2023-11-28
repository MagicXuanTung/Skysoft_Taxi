import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/booking_type.dart';
import 'package:skysoft_taxi/models/save_marker.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/chon_diem.dart';
import 'package:skysoft_taxi/widgets/SlideImage/slide_image_horizontal.dart';
import 'package:skysoft_taxi/widgets/button/button_icon_booking_type.dart';
import 'package:skysoft_taxi/widgets/button/button_save_maker.dart';

class BookingCar extends StatefulWidget {
  const BookingCar({Key? key}) : super(key: key);

  @override
  State<BookingCar> createState() => _BookingCarState();
}

class _BookingCarState extends State<BookingCar> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // Image slider
    List<String> imageSlider = [
      'https://www.ganeshawebtech.com/wp-content/uploads/2018/06/Get-your-taxi-business-an-edge-by-getting-a-Taxi-booking-apps.jpg',
      'https://i.ytimg.com/vi/PN3YyMcHuhc/maxresdefault.jpg',
      'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/263260978/original/01063a5489f4f3bccd2ae5db726c2f156dfbc6e0/taxi-booking-app-car-booking-app-taxi-app-uber-clone-app-car-rental-app.jpg',
      'https://cdn.grabon.in/gograbon/images/merchant/1624792553223.jpg',
      'https://couponswala.com/blog/wp-content/uploads/2021/08/goibibo-cab-coupons.jpg',
      'https://www.icoderzsolutions.com/blog/wp-content/uploads/2021/03/5-Steps-In-Hiring-The-Best-Taxi-App-Development-Company.png',
    ];
    // List options type vehicle
    List<BookingType> listBookingType = [
      BookingType(
          imagePath: 'https://cdn-icons-png.flaticon.com/512/1801/1801444.png',
          text: 'Ô tô'),
      BookingType(
        imagePath:
            'https://cdn2.iconfinder.com/data/icons/transportation-colorized/64/transportation-vehicle-11-512.png',
        text: 'Xe máy',
      ),
      BookingType(
        imagePath:
            'https://icon-library.com/images/on-time-icon/on-time-icon-13.jpg',
        text: 'Thuê xe theo giờ',
      ),
      BookingType(
        imagePath: 'https://www.airasia.com/aa/ride/images/icon-car.png',
        text: 'Sân bay',
      ),
      BookingType(
        imagePath: 'https://cdn-icons-png.flaticon.com/512/4234/4234147.png',
        text: 'Đặt xe cho bạn bè',
      ),
      BookingType(
        imagePath: 'https://cdn-icons-png.flaticon.com/512/6947/6947616.png',
        text: 'Giao Hàng',
      ),
      BookingType(
        imagePath: 'https://cdn-icons-png.flaticon.com/512/776/776443.png',
        text: 'Đồ ăn',
      ),
      BookingType(
        imagePath: 'https://cdn-icons-png.flaticon.com/512/5952/5952766.png',
        text: 'Giao Hàng Ô tô',
      ),
    ];
    // List option places
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
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 90,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listBookingType.length,
                      itemBuilder: (context, index) {
                        BookingType item = listBookingType[index];
                        return ButtonIconBookingType(
                          imagePath: item.imagePath,
                          text: item.text,
                          onTap: () {
                            log(item.text);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  HorizontalImageSlider(
                    imageUrls: imageSlider,
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ChooseDestination();
                        },
                      ),
                    );
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
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const Home(),
                              //   ),
                              // );
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
