import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/banner_image_model.dart';
import 'package:skysoft_taxi/models/booking_type_model.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/chon_diem_den.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/luu_diem_don.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/tim_diem_den%20_nhanh.dart';
import 'package:skysoft_taxi/widgets/imageWidget/banner_image.dart';
import 'package:skysoft_taxi/widgets/imageWidget/slide_image_horizontal.dart';
import 'package:skysoft_taxi/widgets/button/button_icon_booking_type.dart';
import 'package:skysoft_taxi/widgets/button/button_save_maker.dart';

import '../../models/save_marker_model.dart';

class BookingCar extends StatefulWidget {
  const BookingCar({Key? key}) : super(key: key);

  @override
  State<BookingCar> createState() => _BookingCarState();
}

class _BookingCarState extends State<BookingCar> {
  List<String> imageSlider = [
    'https://skysoft.vn/images/banners/sieu-pham-camera-nghi-dinh-10-skybox-mdvr-2c.jpg',
    'https://skysoft.vn/userfiles/404/giai+phap+quan+ly+gui+xe+thong+minh+skysoft+go.jpg',
    'https://thietbigiamsathanhtrinh.com/wp-content/uploads/2023/10/banner-skybox-m8.jpg',
    'https://skysoft.vn/userfiles/341/banner+dadang+may+pos.jpg',
    'https://skysoft.vn/images/sharing-images/may-pos-phat-hanh-ve-dien-tu.jpg',
    'https://skysoft.vn/userfiles/91/skysoft-tracking-system-giai-phap-quan-ly-phuong-tien.jpg',
  ];
  // List options type vehicle
  List<BookingTypeModel> listBookingType = [
    BookingTypeModel(
        imagePath: 'https://cdn-icons-png.flaticon.com/512/1801/1801444.png',
        text: 'Ô tô'),
    BookingTypeModel(
      imagePath:
          'https://cdn2.iconfinder.com/data/icons/transportation-colorized/64/transportation-vehicle-11-512.png',
      text: 'Xe máy',
    ),
    BookingTypeModel(
      imagePath:
          'https://icon-library.com/images/on-time-icon/on-time-icon-13.jpg',
      text: 'Thuê xe theo giờ',
    ),
    BookingTypeModel(
      imagePath: 'https://www.airasia.com/aa/ride/images/icon-car.png',
      text: 'Sân bay',
    ),
    BookingTypeModel(
      imagePath: 'https://cdn-icons-png.flaticon.com/512/4234/4234147.png',
      text: 'Đặt xe cho bạn bè',
    ),
    BookingTypeModel(
      imagePath: 'https://cdn-icons-png.flaticon.com/512/6947/6947616.png',
      text: 'Giao Hàng',
    ),
    BookingTypeModel(
      imagePath: 'https://cdn-icons-png.flaticon.com/512/776/776443.png',
      text: 'Đồ ăn',
    ),
    BookingTypeModel(
      imagePath: 'https://cdn-icons-png.flaticon.com/512/5952/5952766.png',
      text: 'Giao Hàng Ô tô',
    ),
  ];

  late List<SaveMakerModel> listButtonSaveMaker;
// banner behind usernames
  BannerImageModel bannerImageModel = BannerImageModel(
    imageUrl:
        "https://thietbigiamsathanhtrinh.com/wp-content/uploads/2023/10/banner-skybox-m8.jpg",
  );

  @override
  void initState() {
    super.initState();
    listButtonSaveMaker = [
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
      SaveMakerModel(
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              color: const Color.fromARGB(242, 244, 243, 255),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 4,
                        child: Stack(
                          children: [
                            BannerImage(imageUrl: bannerImageModel.imageUrl),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 95,
                              left: 15,
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
                                        maxLines: 2,
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
                            SaveMakerModel item = listButtonSaveMaker[index];
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
                            BookingTypeModel item = listBookingType[index];
                            return ButtonIconBookingType(
                              imagePath: item.imagePath,
                              text: item.text,
                              onTap: () {
                                log(item.text);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ChooseDestination();
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const QuickFindPlaces();
                                      },
                                    ),
                                  );
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
          ],
        ),
      ),
    );
  }
}
