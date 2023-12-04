import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/screen/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: const Color.fromARGB(242, 244, 243, 255),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: screenHeight / 4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://www.pyramidions.com/blog/wp-content/uploads/2018/10/Big-Data.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 55),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * MediaQuery.of(context).size.width,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          log('Bạn đã đóng góp:');
                        },
                        child: Container(
                          height: 100,
                          width: 5 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0.1,
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWDZbxpoLXAkM6Ycqn_zElPOIIke5_Jw7Eug&usqp=CAU',
                              ),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bạn đã đóng góp:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'O VNĐ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Cho quỹ vì tương lai Xelo Taxi',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * MediaQuery.of(context).size.width,
                      ),
                      child: Container(
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
                        child: Column(
                          children: [
                            SmallContainer(
                              iconLeft: Icons.military_tech,
                              text: 'Hạng thành viên',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Hạng thành viên');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.person_add,
                              text: 'Giới thiệu bạn bè',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Giới thiệu bạn bè');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.credit_card,
                              text: 'Thanh toán',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Thanh toán');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.receipt_long,
                              text: 'Thông tin đơn',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Thông tin đơn');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.pin_drop,
                              text: 'Địa chỉ đã lưu',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Địa chỉ đã lưu');
                              },
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * MediaQuery.of(context).size.width,
                      ),
                      child: Container(
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
                        child: Column(
                          children: [
                            SmallContainer(
                              iconLeft: Icons.help,
                              text: 'Trung tâm hỗ trợ',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Trung tâm hỗ trợ');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.policy,
                              text: 'Điều khoản và chính sách',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Điều khoản và chính sách');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.language,
                              text: 'Ngôn Ngữ (Language)',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Ngôn Ngữ (Language)');
                              },
                            ),
                            SmallContainer(
                              iconLeft: Icons.logout,
                              text: 'Đăng xuất',
                              iconRight: Icons.chevron_right,
                              onTap: () {
                                log('Đăng xuất');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * MediaQuery.of(context).size.width,
                      ),
                      child: Container(
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallContainer(
                                  iconLeft: Icons.mail,
                                  text: 'Email CSKH',
                                  iconRight: Icons.chevron_right,
                                  onTap: () {
                                    log('Email CSKH');
                                  },
                                  isLast: true,
                                ),
                                SmallContainer(
                                  iconLeft: Icons.support_agent,
                                  text: '1900 2097',
                                  iconRight: Icons.chevron_right,
                                  onTap: () {
                                    log('1900 2097');
                                  },
                                  isLast: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skysoft Taxi - System 20042',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'V2.0.42/13 - build: 92',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.05 * MediaQuery.of(context).size.width,
                    vertical: 0.2 * screenHeight,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      log("USER INFO");
                    },
                    child: Container(
                      height: 83,
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
                            const CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userModel.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    '037.455.1092',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    log("Điều hướng trang Profile");
                                  },
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    size: 35,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}

class SmallContainer extends StatefulWidget {
  final IconData iconLeft;
  final String text;
  final IconData iconRight;
  final VoidCallback onTap;
  final bool isLast;

  const SmallContainer({
    required this.iconLeft,
    required this.text,
    required this.iconRight,
    required this.onTap,
    this.isLast = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SmallContainer> createState() => _SmallContainerState();
}

class _SmallContainerState extends State<SmallContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(15),
        decoration: BoxDecoration(
          border: widget.isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 0.5,
                  ),
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      widget.iconLeft,
                      size: 20,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Icon(
                  widget.iconRight,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
