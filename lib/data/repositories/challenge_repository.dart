import 'dart:convert';
import 'package:dooit/data/models/challenge/challenge_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/ip.dart';
import '../models/challenge/challenge_list_model.dart';

class ChallengeRepository {
  final client = Client();
  String? tkn;

  Future<ChallengeListModel?> getChallengeList(
    String type,
    String keyword,
    int page,
    int size,
    String sort,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      tkn = pref.getString('access_token');

      final queryParams = {
        'type': type,
        'keyword': keyword,
        'page': page.toString(),
        'size': size.toString(),
        'sort': sort,
      };
      // print(queryParams);

      final response = await client.get(
        Uri.parse('${url}/challenges').replace(queryParameters: queryParams),
        headers: {'Authorization': 'Bearer ${tkn}'},
      );

      final jsonBody = await jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // print(jsonBody['data']['content']);
        final list = ChallengeListModel.fromJson(jsonBody['data']);
        print('챌린지 모두 가져오기 성공!');
        return list;
      }

      print('챌린지 모두 가져오기 실패: ${response.statusCode} ${jsonBody}');
      return null;
    } catch (e) {
      print('챌린지 모두 가져오기 에러다: $e');
      return null;
    }
  }

  Future<String> addChallenge(
    String title,
    String description,
    String type,
    int betPoint,
    int minutes,
    String start,
    String end,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      tkn = pref.getString('access_token');

      final body = {
        "challenge_title": title,
        "challenge_description": description,
        "challenge_type": type,
        "bet_point": betPoint,
        "target_minutes": minutes,
        "start_date": start,
        "end_date": end,
      };

      final response = await client.post(
        Uri.parse('${url}/api/challenges'),
        headers: {
          'Authorization': 'Bearer ${tkn}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      final jsonBody = await jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonBody['message'];
      }

      print('챌린지 생성 실패: ${response.statusCode} ${jsonBody}');
      return jsonBody['message'];
    } catch (e) {
      print('챌린지 생성 에러다: $e');
      return '';
    }
  }

  Future<ChallengeModel?> getChallenge(int id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      tkn = pref.getString('access_token');

      final response = await client.get(
        Uri.parse('${url}/challenges/$id'),
        headers: {'Authorization': 'Bearer ${tkn}'},
      );

      final jsonBody = await jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // print(jsonBody['data']);
        final challenge = ChallengeModel.fromJson(jsonBody['data']);
        // print(jsonBody['data']);
        print('챌린지 가져오기 성공');
        return challenge;
      }

      print('챌린지 가져오기 실패: ${response.statusCode} ${jsonBody}');
      return null;
    } catch (e) {
      print('챌린지 가져오기 에러다: $e');
      return null;
    }
  }

  Future<String> joinChallenge(int id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      tkn = pref.getString('access_token');

      final response = await client.post(
        Uri.parse('${url}/challenges/$id/join'),
        headers: {'Authorization': 'Bearer ${tkn}'},
      );

      final jsonBody = await jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('챌린지 참여 성공');
        return '${jsonBody['message']}';
      }

      print('챌린지 참여 실패: ${response.statusCode} ${jsonBody}');
      return '${jsonBody['message']}';
    } catch (e) {
      print('챌린지 참여 에러다: $e');
      return '';
    }
  }

  Future<int?> getMyChallengeId() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      tkn = pref.getString('access_token');

      final response = await client.get(
        Uri.parse('${url}/challenges/my'),
        headers: {'Authorization': 'Bearer ${tkn}'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonBody = await jsonDecode(response.body);
        // print(jsonBody['data']);
        final id = jsonBody['data']['challenge_id'];
        print('my 챌린지 id 가져오기 성공');
        return id;
      }

      print(
        'my 챌린지 id 가져오기 실패: ${response.statusCode} ${jsonDecode(response.body)}',
      );
      return null;
    } catch (e) {
      print('my 챌린지 id 가져오기 에러다: $e');
      return null;
    }
  }
}
