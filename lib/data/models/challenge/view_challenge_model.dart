class ViewChallengeModel {
  final int challengeId;
  final String challengeTitle;
  final String challengeDescription;
  final String challengeType;
  final int challengeBetPoint;
  final int targetMinutes;
  final String startDate;
  final String endDate;
  final bool finished;

  ViewChallengeModel({
    required this.challengeId,
    required this.challengeTitle,
    required this.challengeDescription,
    required this.challengeType,
    required this.challengeBetPoint,
    required this.targetMinutes,
    required this.startDate,
    required this.endDate,
    required this.finished,
  });

  factory ViewChallengeModel.fromJson(Map<String, dynamic> json) =>
      ViewChallengeModel(
        challengeId: json['challenge_id'],
        challengeTitle: json['challenge_title'],
        challengeDescription: json['challenge_description'],
        challengeType: json['challenge_type'],
        challengeBetPoint: json['challenge_bet_point'],
        targetMinutes: json['target_minutes'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        finished: json['finished'],
      );
}
