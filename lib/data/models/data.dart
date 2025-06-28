final data = Data();

class Data {
  String? name;
  String? tier;
  int? totalPoint;
  int? totalExerTime;

  /// 랭킹
  List? challengeSuccessRanks = [];
  List? havePointRanks = [];
  List? monthExerTimeRanks = [];
  List? weekExerTimeRanks = [];
  List? dailyExerTimeRanks = [];

  ///
  int? today;
  int? total;

  int? todayStat_time;
  int? todayStat_avgTime;

  int? weekStat_time;
  int? weekStat_avgTime;

  int? monthStat_time;
  int? monthStat_avgTime;

  List<Map<String, dynamic>> weekStats = [];

  String? daily;
  int? weeklyDailyAverageWorkoutDuration;
  int? weeklyMaxWorkoutDuration;
}
