// auth_repository.dart
// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/ip.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/sign_in_screen.dart';

class AuthRepository {
  /// 최근 로그인 때 받은 카카오 accessToken
  String? _kakaoAccessToken;

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  // ---------------- 1.  카카오 로그인 ----------------
  Future<void> loginWithKakao(BuildContext context) async {
    try {
      await (await isKakaoTalkInstalled()
          ? UserApi.instance.loginWithKakaoTalk()
          : UserApi.instance.loginWithKakaoAccount());

      final token = await TokenManagerProvider.instance.manager.getToken();
      if (token == null) throw Exception('카카오 토큰 획득 실패');

      _kakaoAccessToken = token.accessToken;
      await _prefs.then(
        (p) => p.setString('kakaoAccessToken', _kakaoAccessToken!),
      );

      // ✔️  얻은 토큰을 곧바로 서버로 전송
      await sendKakaoTokenToServer(context);
    } catch (e) {
      print('❌ Kakao 로그인 실패: $e');
      if (context.mounted) _goSignIn(context);
    }
  }

  // ---------------- 2.  토큰을 서버로 전송 ----------------
  /// 다른 스크립트에서도 호출 가능하도록 public 메서드로 공개
  Future<bool> sendKakaoTokenToServer(BuildContext? context) async {
    final token =
        _kakaoAccessToken ?? (await _prefs).getString('kakaoAccessToken');

    if (token == null || token.isEmpty) {
      print('❌ 저장된 카카오 토큰 없음');
      if (context?.mounted ?? false) _goSignIn(context!);
      return false;
    }

    final res = await http.post(
      Uri.parse('$url/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'access_token': token, 'provider': 'kakao'}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      await _prefs.then((p) {
        p
          ..setString('access_token', body['data']['access_token'])
          ..setString('refresh_token', body['data']['refresh_token']);
      });
      if (context?.mounted ?? false) _goMain(context!);
      return true;
    }

    print('❌ 서버 응답 실패: ${res.statusCode} / ${res.body}');
    if (context?.mounted ?? false) _goSignIn(context!);
    return false;
  }

  // ---------------- 3. 로그아웃 ----------------
  Future<void> logOut(BuildContext context) async {
    final refresh = (await _prefs).getString('refresh_token');
    if (refresh == null) return _goSignIn(context);

    await http.post(
      Uri.parse('$url/api/auth/logout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refresh}),
    );

    final p = await _prefs;
    await p.remove('access_token');
    await p.remove('refresh_token');
    _goSignIn(context);
  }

  // ---------------- 네비게이션 헬퍼 ----------------
  void _goMain(BuildContext context) => Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));

  void _goSignIn(BuildContext context) => Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (_) => const SignInScreen()));
}

// 전역 사용용 인스턴스
final authRepository = AuthRepository();
