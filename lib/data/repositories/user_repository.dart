import 'dart:convert';
import 'package:dooit/data/modles/times.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/ip.dart';

class UserRepository {
  Future<void> getTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString('accessToken');

    if (accessToken == null || accessToken.isEmpty) {
      print('⚠️ accessToken이 없습니다. $accessToken');
      return;
    }
    print('$accessToken');

    final response = await http.get(
      Uri.parse('$url/exer/time'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      times.userToday = data['today']['time'];
      times.userTotal = data['total']['time'];
      times.today = data['today_stat']['time'];
      times.week = data['week_stat']['time'];
      times.month = data['month_stat']['time'];
      times.avgMonth = data['month_stat']['avg_time'];
      times.weekStats = List<Map<String, dynamic>>.from(data['week_stats']);
      times.daily = data['daily'];

      // ✅ 확인용 출력
      print('✅ 시간 정보 불러오기 성공');
      print('오늘 사용 시간: ${times.userToday}');
      print('총 사용 시간: ${times.userTotal}');
      print('오늘 통계 시간: ${times.today}');
      print('이번 주 사용 시간: ${times.week}');
      print('이번 달 사용 시간: ${times.month}');
      print('이번 달 평균 시간: ${times.avgMonth}');
      print('기록된 날짜: ${times.daily}');
      print('주간 사용 기록:');
      for (var day in times.weekStats) {
        print('  ${day['work_date']}: ${day['duration']}초');
      }
    } else {
      print('❌ 시간 정보 요청 실패: ${response.statusCode} / ${response.body}');
    }
  }
}
