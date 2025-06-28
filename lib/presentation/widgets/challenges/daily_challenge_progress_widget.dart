import 'package:capstone_project_2/common/fonts.dart';
import 'package:capstone_project_2/presentantion/providers/challenges/detail_challenge_provider.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../common/colors.dart';

class DailyChallengeProgressWidget extends StatelessWidget {
  const DailyChallengeProgressWidget({super.key, required this.provider});

  final DetailChallengeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(provider.challenge!.myProgressList!.length, (i) {
        double achievement = provider.challenge!.myProgressList![i].achieveMin / provider.challenge!.myProgressList![i].targetMin;
        bool check = provider.challenge!.myProgressList![i].targetMin <= provider.challenge!.myProgressList![i].achieveMin;
        // print(provider.myProgressList[i].targetMin);
        // print(provider.myProgressList[i].achieveMin);
        // print(achievement * 100);
        // print((140 / 100) * (check ? 100 : achievement * 100));
        return Container(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              provider.challenge!.myProgressList![i].today ? Text('ToDay 🔽', style: mediumText(size: 14, color: Colors.black),) : SizedBox.shrink(),
              SizedBox(height: 5,),
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [7, 5],
                  strokeWidth: 1.3,
                  radius: Radius.circular(20),
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: 40,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: greyColor.withValues(alpha: 0.2),
                  ),
                  child: Container(
                    width: 40,
                    height: (140 / 100) * (check ? 100 : achievement * 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(200),
                        top: achievement == 1 || check ? Radius.circular(200) : Radius.zero,
                      ),
                      color: litePointColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(provider.getDate(provider.challenge!.myProgressList![i].day), style: semiBoldText(size: 14, color: Colors.black),)
            ],
          ),
        );
      },),
    );
  }
}
