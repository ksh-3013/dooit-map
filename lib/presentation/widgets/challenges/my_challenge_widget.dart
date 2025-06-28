import 'package:capstone_project_2/presentantion/providers/challenges/my_challenge_provider.dart';
import 'package:capstone_project_2/presentantion/screens/challenges/detail_challenge_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/colors.dart';
import '../../../common/fonts.dart';

class MyChallengeWidget extends StatefulWidget {
  const MyChallengeWidget({super.key});

  @override
  State<MyChallengeWidget> createState() => _MyChallengeWidgetState();
}

class _MyChallengeWidgetState extends State<MyChallengeWidget> {
  final MyChallengeProvider provider = MyChallengeProvider();
  late final int hour;
  late final int minutes;

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider.addListener(updateScreen);
      await provider.getMyChallenge();
      if (provider.myChallenge != null) {
        hour = (provider.myChallenge!.targetMinutes) ~/ 60;
        minutes = (provider.myChallenge!.targetMinutes) % 60;
      }
    });
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onTap: () {
          if (provider.myChallenge != null) {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder:
                    (context) => DetailChallengeScreen(
                      id: provider.myChallenge!.challengeId,
                    ),
              ),
            );
          }
        },
        child: Container(
          // alignment: AlignmentDirectional.centerEnd,
          width: MediaQuery.sizeOf(context).width - 12,
          height: 160,
          decoration: BoxDecoration(
            color: pointColor,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(200)),
          ),
          child:
              provider.myChallenge == null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '아직 참여중인\n챌린지가 없어요',
                        style: semiBoldText(size: 16, color: Colors.white),
                      ),
                      SizedBox(width: 20),
                      Image.asset('assets/images/capstone.png', width: 180),
                      SizedBox(width: 20),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Image.asset('assets/images/capstone.png', width: 180),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '지금 진행 중인 챌린지',
                              style: semiBoldText(size: 16, color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: greyColor,
                            ),
                            SizedBox(height: 8),
                            Text(
                              provider.myChallenge!.challengeTitle,
                              style: semiBoldText(size: 16, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              provider.myChallenge!.challengeDescription,
                              style: mediumText(size: 11, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${provider.myChallenge!.startDate} - ${provider.myChallenge!.startDate}',
                              style: mediumText(
                                size: 11,
                                color: greyColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                // 타입
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                  child: Text(
                                    provider.myChallenge!.challengeType,
                                    style: mediumText(
                                      size: 10,
                                      color: pointColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                // 사간 태그
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                  child: Text(
                                    '${hour == 0 ? '' : hour}${hour == 0 ? '' : '시간'} ${minutes != 0 ? minutes : ''}${minutes != 0 ? '분' : ''}',
                                    style: mediumText(
                                      size: 10,
                                      color: pointColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
