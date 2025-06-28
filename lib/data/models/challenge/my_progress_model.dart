class MyProgressModel {
  final String day;
  final int targetMin;
  final int achieveMin;
  final String type;
  final bool? success;
  final bool today;


  MyProgressModel({
    required this.day,
    required this.targetMin,
    required this.achieveMin,
    required this.type,
    required this.success,
    required this.today,
  });

  factory MyProgressModel.fromJson(Map<String, dynamic> json) => MyProgressModel(
    day: json['day'],
    targetMin: json['target_min'],
    achieveMin: json['achieve_min'],
    type: json['type'],
    success: json['success'],
    today: json['today'],
  );
}
