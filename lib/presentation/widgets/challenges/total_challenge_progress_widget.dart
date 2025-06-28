import 'package:capstone_project_2/common/colors.dart';
import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/data/models/challenge/challenge_model.dart';
import 'package:flutter/material.dart';

class TotalChallengeProgressWidget extends StatelessWidget {
  const TotalChallengeProgressWidget({super.key, required this.challenge});

  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    double achievement = challenge.totalAchieveMinutes! / challenge.targetMinutes;
    bool check = challenge.targetMinutes <= challenge.totalAchieveMinutes!;

    String getAchievementText() {
      if(achievement == 0) {
        return '지금 운동을 시작해 보세요 ✨';
      }
      if(achievement < 1) {
        return '열심히 운동하는 중 🎯';
      }
      return '챌린지를 성공했어요 🎉';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Text(getAchievementText(), style: semiBoldText(size: 16, color: Colors.black)),
              // SizedBox(width: 10,),
              Spacer(),
              Text('${achievement * 100 >= 100 ? 100 : (achievement * 100)
                  .round()}%', style: semiBoldText(
                  size: 16, color: achievement * 100 == 100 || check ? Colors.green : Colors.black),),
              SizedBox(width: 20,),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery
                  .sizeOf(context)
                  .width - 24,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: greyColor.withValues(alpha: 0.2),
              ),
              child: Container(
                height: double.infinity,
                width:
                ((MediaQuery
                    .sizeOf(context)
                    .width - 24) / 100) *
                    (check ? 100 : achievement * 100),
                decoration: BoxDecoration(
                    color: pointColor,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(200),
                      right: check || achievement == 1
                          ? Radius.circular(200) : Radius.zero,
                    )
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
