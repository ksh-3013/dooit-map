import 'dart:convert';
import 'package:dooit/data/repositories/user_repository.dart';
import 'package:dooit/presentation/screens/main_screen.dart';
import 'package:dooit/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/ip.dart';

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
      final kakaoToken = await tokenManager.getToken();
      final kakaoAccessToken = kakaoToken!.accessToken;
      pref.setString('kakaoAccessToken', kakaoAccessToken);
      await sendTokenToServer(context);
    } catch (error) {
      print('로그인에 실패하였습니다 -> $error');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  /// 서버에 토큰 전송
  Future<void> sendTokenToServer(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final kakaoAccessToken = pref.getString('kakaoAccessToken');
    if (kakaoAccessToken == null || kakaoAccessToken.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
      return;
    }
    try {
      final body = {'access_token': kakaoAccessToken, 'provider': 'kakao'};
      final response = await http.post(
        Uri.parse('$url/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('✅ 서버에 토큰 전송 성공: ${response.body}');
        final responseData = jsonDecode(response.body);
        pref.setString('access_token', responseData['data']['access_token']);
        pref.setString('refresh_token', responseData['data']['refresh_token']);
        userRepository.userInfo();
        await userRepository.getRank();
        await userRepository.getTime();
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

  /// 로그아웃
  Future<void> logOut(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('access_token');
    final refreshToken = pref.getString('refresh_token');
    try {
      final body = {'refresh_token': refreshToken};
      print(refreshToken);
      print(accessToken);
      final response = await http.post(
        Uri.parse('$url/api/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('✅ 서버에 토큰 전송 성공: ${response.body}');
        await pref.remove('refresh_token');
        await pref.remove('access_token');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } else {
        print('❌ 서버 응답 실패: ${response.statusCode} / ${response.body}');
      }
    } catch (e) {
      print('💥 토큰 전송 에러: $e');
    }
  }
}
