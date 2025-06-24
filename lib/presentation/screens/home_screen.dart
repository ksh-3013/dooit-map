import 'package:dooit/data/modles/times.dart';
import 'package:dooit/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserRepository userRepository = UserRepository();

  void handleTap(int index) {
    switch (index) {
      case 0:
        // _launchURL(url0);
        break;
      case 1:
        // _launchURL(url1);
        break;
      case 2:
        // _launchURL(url2);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    userRepository.getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6EFE9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home_screen_title.png',
                    width: 250,
                    height: 100,
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xffF1E7DE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/glowing_star.png',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        Text(
                          '개',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.notifications, color: Colors.grey, size: 30),
                ],
              ),
            ),
            Stack(
              children: [
                Image.asset(
                  'assets/images/timer_bg.png',
                  width: 350,
                  height: 350,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(times.daily)],
                ),
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 190,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Check-in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 190,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color(0xff5D29CC),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/fire.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '입실하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            CustomSwiper(
              items: List.generate(3, (index) {
                return Image.asset(
                  'assets/images/banner${index + 1}.png',
                  fit: BoxFit.cover,
                );
              }),
              height: 100,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              onTap: (index) => handleTap(index),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이번 주 공부 시간',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '00m 00s',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 43,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '이번 주 공부 기록이 없어요😫',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: 'Prendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 55),
                      Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '공부 분석 보기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
