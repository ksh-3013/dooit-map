/// 전역 싱글턴 대신 Provider/Riverpod 등에 넘겨도 되지만
/// 지금 구조를 유지하려면 ‘late final’로 한 번만 초기화
final data = Data();

class Data {
  // -------------------------------------------------------------------------
  // 1. 기본 정보 --------------------------------------------------------------
  // -------------------------------------------------------------------------
  String name = '';
  String tier = '';
  int totalPoint = 0;
  int totalExerTime = 0;

  // -------------------------------------------------------------------------
  // 2. 랭킹 ------------------------------------------------------------------
  // -------------------------------------------------------------------------
  List<dynamic> challengeSuccessRanks = const [];
  List<dynamic> havePointRanks = const [];
  List<dynamic> monthExerTimeRanks = const [];
  List<dynamic> weekExerTimeRanks = const [];
  List<dynamic> dailyExerTimeRanks = const [];

  // -------------------------------------------------------------------------
  // 3. 오늘 / 누적 ------------------------------------------------------------
  // -------------------------------------------------------------------------
  int today = 0;
  int total = 0;

  // -------------------------------------------------------------------------
  // 4. 통계 ---------------------------------------------------------------
  // -------------------------------------------------------------------------
  int todayStatTime = 0;
  int todayStatAvgTime = 0;

  int weekStatTime = 0;
  int weekStatAvgTime = 0;

  int monthStatTime = 0;
  int monthStatAvgTime = 0;

  List<Map<String, dynamic>> weekStats = const [];

  String daily = ''; // yyyy‑MM‑dd
  int weeklyDailyAverageWorkoutDuration = 0;
  int weeklyMaxWorkoutDuration = 0;

  // -------------------------------------------------------------------------
  // 5. JSON 파싱 헬퍼 (선택) ---------------------------------------------------
  // -------------------------------------------------------------------------
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    name = json['data']['name'] ?? '';
    tier = json['data']['tier'] ?? '';
    totalPoint = json['data']['totalPoint'] ?? 0;
    totalExerTime = json['data']['totalExerTime'] ?? 0;

    // 랭킹 배열은 nullable + dynamic 형태가 많아 List.cast 불가 시 const []
    challengeSuccessRanks = List.from(
      json['data']['challenge_success_ranks'] ?? const [],
    );
    havePointRanks = List.from(json['data']['have_point_ranks'] ?? const []);
    monthExerTimeRanks = List.from(
      json['data']['month_exer_time_ranks'] ?? const [],
    );
    weekExerTimeRanks = List.from(
      json['data']['week_exer_time_ranks'] ?? const [],
    );
    dailyExerTimeRanks = List.from(
      json['data']['daily_exer_time_ranks'] ?? const [],
    );

    today = json['data']['today'] ?? 0;
    total = json['data']['total'] ?? 0;

    todayStatTime = json['data']['today_stat_time'] ?? 0;
    todayStatAvgTime = json['data']['today_stat_avgTime'] ?? 0;

    weekStatTime = json['data']['week_stat_time'] ?? 0;
    weekStatAvgTime = json['data']['week_stat_avgTime'] ?? 0;

    monthStatTime = json['data']['month_stat_time'] ?? 0;
    monthStatAvgTime = json['data']['month_stat_avgTime'] ?? 0;

    weekStats = List<Map<String, dynamic>>.from(
      json['data']['week_stats'] ?? const [],
    );

    daily = json['daily'] ?? '';
    weeklyDailyAverageWorkoutDuration =
        json['data']['weeklyDailyAverageWorkoutDuration'] ?? 0;
    weeklyMaxWorkoutDuration = json['data']['weeklyMaxWorkoutDuration'] ?? 0;
  }

  // 필요하다면 toJson, copyWith, equality(Equatable) 도 추가해 두세요.
}
