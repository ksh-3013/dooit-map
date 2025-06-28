import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/data/models/challenge/view_challenge_model.dart';
import 'package:capstone_project_2/presentantion/screens/challenges/detail_challenge_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/fonts.dart';

class ChallengeItem extends StatelessWidget {
  const ChallengeItem({super.key, required this.challenge});

  final ViewChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final hour = (challenge.targetMinutes) ~/ 60;
    final minutes = (challenge.targetMinutes) % 60;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => DetailChallengeScreen(id: challenge.challengeId,),));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 90,
        width: double.infinity,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  // 타입
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: litePointColor,
                    ),
                    child: Text(challenge.challengeType, style: mediumText(size: 10, color: pointColor),),
                  ),
                  SizedBox(width: 10,),
                  // 시간 태그
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: litePointColor,
                    ),
                    child: Text('${hour == 0 ? '' : hour}${hour == 0 ? '' : '시간'} ${minutes != 0 ? minutes : ''}${minutes != 0 ? '분' : ''}', style: mediumText(size: 10, color: pointColor),),
                  ),
                  Spacer(),
                  // 포인트
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
                        Image.asset('assets/images/star.png', width: 20,),
                        SizedBox(width: 5,),
                        Text('${challenge.challengeBetPoint}', style: semiBoldText(size: 12, color: Colors.white),)
                      ],
                    ),
                  ),
                ],),
                Text(challenge.challengeTitle, style: semiBoldText(size: 16, color: Colors.black),),
                Text(challenge.challengeDescription, style: mediumText(size: 11, color: Color(0xFFA6A6A6)),),
                Text('${challenge.startDate} - ${challenge.startDate}', style: mediumText(size: 11, color: Color(0xFFA6A6A6)),),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}
