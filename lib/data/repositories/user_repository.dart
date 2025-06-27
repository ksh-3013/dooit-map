import 'dart:convert';
import 'package:dooit/data/modles/data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/ip.dart';

UserRepository userRepository = UserRepository();

class UserRepository {
  Future<void> userInfo() async {
    print('화면 갱신 호출됨');
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('access_token');
    final refreshToken = pref.getString('refresh_token');
    final response = await http.get(
      Uri.parse('$url/api/user/info'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      data.name = responseData['data']['name'];
      data.tier = responseData['data']['tier'];
      data.totalPoint = responseData['data']['totalPoint'];
      data.totalExerTime = responseData['data']['totalExerTime'];
    } else {
      print('⛔️ 서버 응답 오류: ${response.statusCode}');
    }
  }

  Future<void> getTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = await pref.getString('access_token');
    final response = await http.get(
      Uri.parse('$url/api/exer/time'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      data.today = responseData['data']['today']['time'];
      data.total = responseData['data']['total']['time'];
      data.todayStat_time = responseData['data']['today_stat']['time'];
      data.todayStat_avgTime = responseData['data']['today_stat']['avg_time'];
      data.weekStat_time = responseData['data']['week_stat']['time'];
      data.weekStat_avgTime = responseData['data']['week_stat']['avg_time'];
      data.monthStat_time = responseData['data']['month_stat']['time'];
      data.monthStat_avgTime = responseData['data']['month_stat']['avg_time'];
      data.weekStats = List<Map<String, dynamic>>.from(
        responseData['data']['week_stats'],
      );
      data.daily = responseData['data']['daily'];
    }
    print(data.weekStats[1]);
    print('${data.weekStats}');
  }

  Future<void> getRank() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('access_token');
    final refreshToken = pref.getString('refresh_token');
    final response = await http.get(
      Uri.parse('$url/api/rank'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      data.challengeSuccessRanks =
          responseData['data']['challengeSuccessRanks'];
      data.havePointRanks = responseData['data']['havePointRanks'];
      data.monthExerTimeRanks = responseData['data']['monthExerTimeRanks'];
      data.weekExerTimeRanks = responseData['data']['weekExerTimeRanks'];
      data.dailyExerTimeRanks = responseData['data']['dailyExerTimeRanks'];
    }
  }
}
