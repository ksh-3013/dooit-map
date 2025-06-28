import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/presentantion/providers/challenges/detail_challenge_provider.dart';
import 'package:capstone_project_2/presentantion/widgets/challenges/daily_challenge_progress_widget.dart';
import 'package:capstone_project_2/presentantion/widgets/challenges/total_challenge_progress_widget.dart';
import 'package:flutter/material.dart';

class DetailChallengeScreen extends StatefulWidget {
  const DetailChallengeScreen({super.key, required this.id});

  final int id;

  @override
  State<DetailChallengeScreen> createState() => _DetailChallengeScreenState();
}

class _DetailChallengeScreenState extends State<DetailChallengeScreen> {

  final DetailChallengeProvider detailChallengeProvider = DetailChallengeProvider();
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      detailChallengeProvider.addListener(updateScreen);
      await detailChallengeProvider.getChallenge(widget.id);
    });
  }

  @override
  void dispose() {
    detailChallengeProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
            detailChallengeProvider.challenge == null
                ? Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('챌린지 정보를 불러오는 중입니다'),
                        SizedBox(width: 5,),
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      // 챌린지 이미지
                      Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey,
                        child: Image.asset('assets/images/challenge_imgs/9.png', fit: BoxFit.cover,),
                      ),
                      // 설명
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 25,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              detailChallengeProvider.challenge!.challengeTitle,
                              style: semiBoldText(size: 22, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              detailChallengeProvider.challenge!.challengeDescription,
                              style: mediumText(size: 14, color: greyColor),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.flag, size: 25, color: greyColor),
                                SizedBox(width: 5),
                                Text(
                                  detailChallengeProvider.challenge!.challengeTitle,
                                  style: mediumText(
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            // 포인트
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: pointColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/star.png',
                                        width: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${detailChallengeProvider.challenge!.challengeBetPoint}',
                                        style: semiBoldText(
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: greyColor.withOpacity(0.2),
                            ),
                            SizedBox(height: 15,),
                            // 작성자 정보
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 15,),
                                // 사용자 정보
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 7),
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                        color: litePointColor,
                                      ),
                                      child: Text(detailChallengeProvider.challenge!.tier, style: semiBoldText(size: 9, color: pointColor),),
                                    ),
                                    SizedBox(height: 3,),
                                    Text(detailChallengeProvider.challenge!.userName, style: mediumText(size: 14, color: greyColor),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 중간바
                      Container(
                        width: double.infinity,
                        height: 15,
                        color: greyColor.withOpacity(0.2),
                      ),
                      // 인증 방법
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 30,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  detailChallengeProvider.challenge!.challengeType == 'DAILY' ? 'DAILY' : 'TOTAL',
                                  style: semiBoldText(size: 22, color: pointColor),
                                ),
                                Text(
                                  ' 인증은 이렇게 해요',
                                  style: semiBoldText(
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              '두잇 타이머의 시간이 기록되면 자동으로 인증돼요!\n챌린지 기간 동안 공부 시간 목표를 향해 타이머를 측정해\n주세요!',
                              style: mediumText(size: 14, color: greyColor),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                      detailChallengeProvider.challenge!.myProgressList != null
                          ? detailChallengeProvider.challenge!.challengeType == 'TOTAL'
                            ? TotalChallengeProgressWidget(challenge: detailChallengeProvider.challenge!)
                            : DailyChallengeProgressWidget(provider: detailChallengeProvider,)
                          : SizedBox.shrink(),
                      SizedBox(height: 30,),
                    ],
                  ),
                  // 뒤로가기
                  Positioned(
                    top: 15,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.white),
                    ),
                  ),
                  // 사람 수와 포인트
                  Positioned(top: 230, child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.white,
                      border: Border.all(width: 1.5, color: greyColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('모인 포인트 ', style: semiBoldText(size: 14, color: Colors.black),),
                        Text('${detailChallengeProvider.challenge!.totalBetPoint}개', style: semiBoldText(size: 14, color: pointColor),),
                        SizedBox(width: 10,),
                        Text('${detailChallengeProvider.challenge!.participants}명', style: mediumText(size: 12, color: greyColor),),
                      ],
                    ),
                  )),
                ],
              ),
            ),
        bottomNavigationBar: detailChallengeProvider.challenge == null ? null : Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 20),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 기간
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month, size: 25, color: greyColor),
                        SizedBox(width: 5),
                        SizedBox(
                          child: Column(
                            children: [
                              Text(
                                detailChallengeProvider.challenge!.challengeType == 'TOTAL'
                                    ? '${detailChallengeProvider.getStartDate()} ~ ${detailChallengeProvider.getEndDate()}'
                                    : detailChallengeProvider.getStartDate(),
                                style: semiBoldText(size: 14, color: Colors.black),
                              ),
                              // 밑줄
                              Container(
                                width:
                                detailChallengeProvider.challenge!.challengeType == 'TOTAL'
                                        ? 100
                                        : 45,
                                height: 1.2,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // 참여
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final message = await detailChallengeProvider.joinChallenge(widget.id);
                        if(message.contains('성공')) {
                          Navigator.of(context).pop();
                        } else {
                          String errorMessage = '';
                          for(int i = 8; i < message.length; i++) {
                            errorMessage += message[i];
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage))
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width * 0.43,
                        height: 60,
                        decoration: BoxDecoration(
                          color: pointColor,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Text(
                          '참가하기',
                          style: semiBoldText(size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
