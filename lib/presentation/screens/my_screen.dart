import 'package:dooit/common/colors.dart';
import 'package:dooit/presentation/providers/my_provider.dart';
import 'package:dooit/presentation/widgets/change_name_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/fonts.dart';
import '../shop/shop_screen.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      myProvider.addListener(updateScreen);
      await myProvider.getMyData();
      myProvider.setTime();
    });
  }

  @override
  void dispose() {
    myProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      // backgroundColor: Colors.white,
      body:
          myProvider.userData == null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('내 정보를 불러오는 중 입니다.'),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // 상단
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Text(
                            'MY Dooit',
                            style: blackText(size: 30, color: Colors.black),
                          ),
                          Spacer(),
                          Icon(
                            Icons.settings,
                            size: 30,
                            color: Color(0xFFA6A6A6),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.notifications,
                            color: Color(0xFFA6A6A6),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    // 사용자 정보
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: MediaQuery.sizeOf(context).width * 0.8,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Image.asset(
                                  'assets/images/profile_image.png',
                                  fit: BoxFit.cover,
                                ),
                                // Padding(
                                //   padding: EdgeInsets.all(10),
                                //   child: GestureDetector(
                                //     onTap: () {},
                                //     child: Container(
                                //       width: 30,
                                //       height: 30,
                                //       decoration: BoxDecoration(
                                //         shape: BoxShape.circle,
                                //         color: Colors.black,
                                //       ),
                                //       child: Icon(
                                //         Icons.arrow_forward,
                                //         size: 20,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 티어
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: litePointColor,
                                    ),
                                    child: Text(
                                      myProvider.userData!.tier,
                                      style: semiBoldText(
                                        size: 14,
                                        color: pointColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // 이름
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text(
                                    myProvider.userData!.name,
                                    style: semiBoldText(
                                      size: 28,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder:
                                              (context) => ChangeNameWidget(userName: myProvider.userData!.name,),
                                        ),
                                      ).then((value) async {
                                        await myProvider.getMyData();
                                      },);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // 포인트
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/star.png',
                                          width: 25,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          '${myProvider.userData!.totalPoint}',
                                          style: semiBoldText(
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          ' 개',
                                          style: semiBoldText(
                                            size: 16,
                                            color: Color(0xFFA6A6A6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

                    // 배너
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      height: 92,
                      color: Color(0xFFFFD452),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Color(0xFF8BC6C1),
                                ),
                                child: Text(
                                  'CUIDE',
                                  style: semiBoldText(
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                '운동 타이머 헬스장에서 함께!',
                                style: semiBoldText(size: 24, color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(width: 60, height: 60, color: Colors.blue),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          // 총 운동 시간
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled_outlined,
                                  size: 40,
                                  color: litePointColor,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '지금까지 총',
                                      style: mediumText(
                                        size: 14,
                                        color: greyColor,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${myProvider.hour! == 0 ? '' : myProvider.hour!}${myProvider.hour! == 0 ? '' : '시간'} ${myProvider.minutes! != 0 ? myProvider.minutes! : ''}${myProvider.minutes! != 0 ? '분' : ''}',
                                      style: semiBoldText(
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '동안 운동 했어요',
                                      style: mediumText(
                                        size: 14,
                                        color: greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          // 선택 항목
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ShopScreen(),)).then((value) async {
                                await myProvider.getMyData();
                              },);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: litePointColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                    color: pointColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '상품 구매',
                                    style: semiBoldText(
                                      size: 16,
                                      color: pointColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
