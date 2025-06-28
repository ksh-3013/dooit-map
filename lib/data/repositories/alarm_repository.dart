import 'dart:convert';

import 'package:dooit/core/ip.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AlarmRepository {
  Future<void> getAlarm() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('access_token');
    final response = await http.get(
      Uri.parse('$url/api/notifications/views'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
    }
  }
}
