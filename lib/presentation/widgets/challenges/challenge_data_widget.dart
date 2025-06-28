import 'package:capstone_project_2/presentantion/providers/challenges/add_challenge_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/colors.dart';
import '../../../common/fonts.dart';

class ChallengeDataWidget extends StatelessWidget {
  const ChallengeDataWidget({super.key, required this.provider});

  final AddChallengeProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.flag, size: 25, color: greyColor),
                SizedBox(width: 5),
                Text(
                  (provider.targetMinutes ~/ 60) == 0 ? '${provider.targetMinutes}분 운동하기' : '${provider.targetMinutes ~/ 60}시간 ${provider.targetMinutes % 60}분 운동하기',
                  style: mediumText(
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.calendar_month, size: 25, color: greyColor),
                SizedBox(width: 5),
                Text(
                  provider.challengeType == 'TOTAL'
                      ? '${DateFormat('MM-dd').format(provider.start)} ~ ${DateFormat('MM-dd').format(provider.end)}'
                      : DateFormat('MM-dd').format(provider.start),
                  style: mediumText(
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 35,
                  decoration: BoxDecoration(
                    color: pointColor,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/star.png', width: 25,),
                      SizedBox(width: 2,),
                      Text(provider.betPointController.text, style: semiBoldText(size: 16, color: Colors.white),),
                      Text(' 개', style: semiBoldText(size: 16, color: Color(0xFFA6A6A6)),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            _customTextField(title: '챌린지명', controller: provider.titleController, hint: 'ex) 매일 1시간씩만'),
            _customTextField(title: '', controller: provider.descriptionController, hint: '챌린지 설명을 입력해주세요', rows: true),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () async {
                provider.addChallenge(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: pointColor,
                ),
                child: Text(
                  '챌린지 개설 완료',
                  style: semiBoldText(size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _customTextField({
    required String title,
    required TextEditingController controller,
    bool rows = false,
    TextInputType keyboard = TextInputType.text,
    String hint = '',
  }) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            children: [
              SizedBox(width: 20),
              Text(title, style: semiBoldText(size: 16, color: Colors.black)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rows ? 30 : 200),
            color: Color(0xFFF1E7DE),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboard,
            style: semiBoldText(size: 16, color: Colors.black),
            maxLines: rows ? null : 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: semiBoldText(size: 16, color: Color(0xFFA6A6A6)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }

}
