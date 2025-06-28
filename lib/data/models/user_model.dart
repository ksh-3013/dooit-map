class UserModel {
  final String name;
  final String tier;
  final int totalPoint;
  final int totalExerTime;

  UserModel({
    required this.name,
    required this.tier,
    required this.totalPoint,
    required this.totalExerTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'],
    tier: json['tier'],
    totalPoint: json['total_point'],
    totalExerTime: json['total_exer_time'],
  );
}
