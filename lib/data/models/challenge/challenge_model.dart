import 'package:dooit/data/models/challenge/my_progress_model.dart';

class ChallengeModel {
  final int challengeId;
  final String challengeTitle;
  final String challengeDescription;
  final String challengeType;
  final int challengeBetPoint;
  final int targetMinutes;
  final String startDate;
  final String endDate;
  final int participants;
  final int totalBetPoint;
  final String userName;
  final String tier;
  final List<MyProgressModel>? myProgressList;
  final int? totalAchieveMinutes;
  // final String imgCode;

  ChallengeModel({
    required this.challengeId,
    required this.challengeTitle,
    required this.challengeDescription,
    required this.challengeType,
    required this.challengeBetPoint,
    required this.targetMinutes,
    required this.startDate,
    required this.endDate,
    required this.participants,
    required this.totalBetPoint,
    required this.userName,
    required this.tier,
    required this.myProgressList,
    required this.totalAchieveMinutes,
    // required this.imgCode,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    List<MyProgressModel>? myProgressList;
    if(json['my_progress_list'] != null) {
      myProgressList = [];
      for(var myProgress in json['my_progress_list']) {
        myProgressList.add(MyProgressModel.fromJson(myProgress));
      }
    }
    return ChallengeModel(
      challengeId: json['challenge_id'],
      challengeTitle: json['challenge_title'],
      challengeDescription: json['challenge_description'],
      challengeType: json['challenge_type'],
      challengeBetPoint: json['challenge_bet_point'],
      targetMinutes: json['target_minutes'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      participants: json['participants'],
      totalBetPoint: json['total_bet_point'],
      userName: json['user_name'],
      tier: json['tier'],
      myProgressList: myProgressList,
      totalAchieveMinutes: json['total_acheive_minutes'], // 철자 나중에 바꿀꺼
      // imgCode: json['imgCode'],
    );
  }
}