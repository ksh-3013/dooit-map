import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/presentantion/providers/challenges/add_challenge_provider.dart';
import 'package:flutter/material.dart';

class SelectChallengeTypeWidget extends StatelessWidget {
  const SelectChallengeTypeWidget({super.key, required this.provider});

  final AddChallengeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Text('도전할 챌린지를 만들어 주세요', style: semiBoldText(size: 25, color: Colors.black),),
        ),
        Text('챌린지 타입을 골라주세요', style: semiBoldText(size: 16, color: Colors.black),),
        SizedBox(height: 10,),
        _typeBox(type: 'DAILY', content: '기간 내 매일 목표 운동 시간 달성 챌린지', ex: '매일 3시간 운동하기'),
        SizedBox(height: 10,),
        _typeBox(type: 'TOTAL', content: '기간 내 목표 운동 시간 달성 챌린지', ex: '2주간 30시간 운동하기'),
      ],
    );
  }

  Widget _typeBox({required String type, required String content, required String ex}) {
    return GestureDetector(
      onTap: () {
        provider.changeChallengeType(type);
        provider.changeStep(1);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(type, style: semiBoldText(size: 16, color: Colors.black),),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white,),
                ),
              ],
            ),
            Text(content, style: semiBoldText(size: 14, color: greyColor),),
            Text('ex) $ex', style: semiBoldText(size: 12, color: Colors.orange),),
          ],
        ),
      ),
    );
  }

}
