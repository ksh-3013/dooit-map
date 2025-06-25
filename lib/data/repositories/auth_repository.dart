import 'dart:convert';
import 'package:dooit/common/ip.dart';
import 'package:dooit/presentation/screens/main_screen.dart';
import 'package:dooit/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  /// 카카오 로그인
  Future<void> loginWithKakao(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await isKakaoTalkInstalled()
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      User user = await UserApi.instance.me();
      String? email = user.kakaoAccount?.email;
      pref.setString('email', email!);
      if (email != null) {
        print(email);
      }

      final tokenManager = TokenManagerProvider.instance.manager;
      final token = await tokenManager.getToken();
      final accessToken = token!.accessToken;
      pref.setString('accessToken', accessToken);
      await sendTokenToServer(context);
    } catch (error) {
      print('로그인에 실패하였습니다 -> $error');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  Future<void> sendTokenToServer(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');
    if (accessToken == null || accessToken.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
      return;
    }
    try {
      final body = {'access_token': accessToken, 'provider': 'kakao'};
      final response = await http.post(
        Uri.parse('$url/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('✅ 서버에 토큰 전송 성공: ${response.body}');
        SharedPreferences pref = await SharedPreferences.getInstance();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        print('❌ 서버 응답 실패: ${response.statusCode} / ${response.body}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    } catch (e) {
      print('💥 토큰 전송 에러: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  Future<void> logOut(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');
    try {
      final body = {'access_token': accessToken};
      final response = await http.post(
        Uri.parse('$url/api/auth/logOut'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('✅ 서버에 토큰 전송 성공: ${response.body}');
        SharedPreferences pref = await SharedPreferences.getInstance();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        print('❌ 서버 응답 실패: ${response.statusCode} / ${response.body}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    } catch (e) {
      print('💥 토큰 전송 에러: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }
}
