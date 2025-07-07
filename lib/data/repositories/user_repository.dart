// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/ip.dart';
import '../models/data.dart';
import '../models/user_model.dart';

/// 모든 **유저 관련 네트워크 요청**을 담당하는 리포지토리.
///
/// - null‑safe & 예외 안전 처리
/// - 중복 로직(토큰 얻기, 공통 헤더 등) 헬퍼로 통일
/// - 단일 책임: JSON → Model 파싱은 모델에 위임
class UserRepository {
  // ---------------------------------------------------------------------------
  // 공통 헬퍼
  // ---------------------------------------------------------------------------

  Future<String?> _getAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('access_token');
  }

  Map<String, String> _authHeader(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  Future<http.Response> _get(String path) async {
    final token = await _getAccessToken();
    if (token == null) {
      throw Exception('액세스 토큰이 없습니다');
    }
    final uri = Uri.parse('$url$path');
    return http.get(uri, headers: _authHeader(token));
  }

  Future<http.Response> _post(String path, {Map<String, String>? qp}) async {
    final token = await _getAccessToken();
    if (token == null) {
      throw Exception('액세스 토큰이 없습니다');
    }
    final uri = Uri.parse('$url$path').replace(queryParameters: qp);
    return http.post(uri, headers: _authHeader(token));
  }

  // ---------------------------------------------------------------------------
  // 1. 내 기본 정보
  // ---------------------------------------------------------------------------

  Future<void> fetchUserInfo() async {
    try {
      final res = await _get('/api/user/info');
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        final d = body['data'] as Map<String, dynamic>? ?? {};
        data
          ..name = d['name'] ?? ''
          ..tier = d['tier'] ?? ''
          ..totalPoint = d['totalPoint'] ?? 0
          ..totalExerTime = d['totalExerTime'] ?? 0;
      } else {
        print('❌ fetchUserInfo 실패: ${res.statusCode}');
      }
    } catch (e) {
      print('❌ fetchUserInfo 예외: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // 2. 운동 시간 통계
  // ---------------------------------------------------------------------------

  Future<void> fetchExerciseTime() async {
    try {
      final res = await _get('/api/exer/time');
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        final d = body['data'] as Map<String, dynamic>? ?? {};

        data
          ..today = d['today']?['time'] ?? 0
          ..total = d['total']?['time'] ?? 0
          ..todayStatTime = d['today_stat']?['time'] ?? 0
          ..todayStatAvgTime = d['today_stat']?['avg_time'] ?? 0
          ..weekStatTime = d['week_stat']?['time'] ?? 0
          ..weekStatAvgTime = d['week_stat']?['avg_time'] ?? 0
          ..monthStatTime = d['month_stat']?['time'] ?? []
          ..monthStatAvgTime = d['month_stat']?['avg_time'] ?? 0
          ..weekStats = List<Map<String, dynamic>>.from(
            d['week_stats'] ?? <Map<String, dynamic>>[],
          )
          ..daily = d['daily'] ?? ''
          ..weeklyDailyAverageWorkoutDuration =
              d['weekly_daily_average_workout_duration'] ?? 0
          ..weeklyMaxWorkoutDuration = d['weekly_max_workout_duration'] ?? 0;
      } else {
        print('❌ fetchExerciseTime 실패: ${res.statusCode}');
      }
    } catch (e) {
      print('❌ fetchExerciseTime 예외: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // 3. 랭킹 정보
  // ---------------------------------------------------------------------------

  Future<void> fetchRank() async {
    try {
      final res = await _get('/api/rank');
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        final d = body['data'] as Map<String, dynamic>? ?? {};
        data
          ..challengeSuccessRanks = d['challenge_success_ranks'] ?? '0'
          ..havePointRanks = d['have_point_ranks'] ?? '0'
          ..monthExerTimeRanks = d['month_exer_time_ranks'] ?? '0'
          ..weekExerTimeRanks = d['week_exer_time_ranks'] ?? '0'
          ..dailyExerTimeRanks = d['daily_exer_time_ranks'] ?? '0';
      } else {
        print('❌ fetchRank 실패: ${res.statusCode}');
      }
    } catch (e) {
      print('❌ fetchRank 예외: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // 4. 내 정보 (모델 반환)
  // ---------------------------------------------------------------------------

  Future<UserModel?> getMyData() async {
    try {
      final res = await _get('/user/info');
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final myData = UserModel.fromJson(body['data'] as Map<String, dynamic>);
        print('✅ 내 정보 가져오기 성공');
        return myData;
      }
      print('❌ 내 정보 가져오기 실패: ${res.statusCode} $body');
      return null;
    } catch (e) {
      print('❌ getMyData 예외: $e');
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 5. 닉네임 변경 (응답 메시지 반환)
  // ---------------------------------------------------------------------------

  Future<String> changeUserName(String name) async {
    try {
      final res = await _post('/user/name', qp: {'name': name});
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return body['message'] ?? '닉네임이 변경되었습니다';
      }
      return body['message'] ?? '닉네임 변경 실패';
    } catch (e) {
      print('❌ changeUserName 예외: $e');
      return '닉네임 변경 중 오류가 발생했어요';
    }
  }
}

// 전역 인스턴스 (필요하면 DI로 교체)
final userRepository = UserRepository();
