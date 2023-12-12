import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/models/banner_image_model.dart';
import 'package:skysoft_taxi/models/circular_image_widget_model.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/chon_diem_den.dart';
import 'package:skysoft_taxi/widgets/imageWidget/banner_image.dart';
import 'package:skysoft_taxi/widgets/imageWidget/circular_image_widget.dart';

class ActivityDaily extends StatefulWidget {
  const ActivityDaily({Key? key}) : super(key: key);

  @override
  State<ActivityDaily> createState() => _ActivityDailyState();
}

class _ActivityDailyState extends State<ActivityDaily> {
  BannerImageModel bannerImageModel = BannerImageModel(
    imageUrl: "https://toataxis.co.uk/uploads/toa-banner-image-3.jpg.webp",
  );

  CircularImageModel circularImageModel = CircularImageModel(
    imageUrl:
        "https://image.winudf.com/v2/image1/Y29tLnNreXNvZnQuZ3BzX2ljb25fMTU1OTE4NzY5NF8wMjQ/icon.png?w=184&fakeurl=1",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(242, 244, 243, 255),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                BannerImage(imageUrl: bannerImageModel.imageUrl),
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
