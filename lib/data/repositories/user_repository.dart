import 'dart:convert';
import 'package:dooit/core/token_storage.dart';
import 'package:dooit/data/modles/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/ip.dart';

class UserRepository {
  Future<void> userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('tkn');
    try {
      final response = await http.get(
        Uri.parse('$url/api/user/info'),
        headers: {'Authorization': 'Bearer ${tkn}'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        userData.name = data['name'];
        userData.tier = data['tier'];
      } else {
        print('⛔️ 서버 응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ 네트워크/파싱 오류: $e');
    }
  }

  Future<void> setUsername() async {}
}
